package sforum.utils;


import sforum.model.Forum;
import sforum.model.Topic;
import sforum.web.controller.httpcodes.Errors;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {

	private static SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy.");
	private static SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
	private static SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy. HH:mm:ss");

	private static Pattern urlPattern = Pattern.compile("\\+|%21|%27|%28|%29|%7E");

	public static String formatDate(final Date date) {
		return date == null ? "" : dateFormat.format(date);
	}

	public static String formatTime(final Date time) {
		return time == null ? "" :  timeFormat.format(time);
	}

	public static String formatDateTime(final Date dateTime) {
		return dateTime == null ? "" :  dateTimeFormat.format(dateTime);
	}

	public static Integer subtractYear(final Date date1, final Date date2) {
		if (date1 == null || date2 == null)
			return null;
		return date1.getYear() - date2.getYear();
	}

	public static void checkNull(final Object obj) {

		if (obj == null)
			throw new Errors.BadRequest();
	}

	public static String encodeURIComponent(final String str) {

		try {
			final String res1 = URLEncoder.encode(str, "UTF-8");
			final StringBuffer sb = new StringBuffer(res1.length());
			final Matcher m = urlPattern.matcher(res1);
			while (m.find()) {
				switch (m.group()) {
					case "+": m.appendReplacement(sb, "%20"); break;
					case "%21": m.appendReplacement(sb, "!"); break;
					case "%27": m.appendReplacement(sb, "'"); break;
					case "%28": m.appendReplacement(sb, "("); break;
					case "%29": m.appendReplacement(sb, ")"); break;
					case "%7E": m.appendReplacement(sb, "~"); break;
				}
			}
			m.appendTail(sb);
			return sb.toString();
		} catch (final UnsupportedEncodingException e) {
			return null;
		}
	}

	public static String topicURL(final Topic topic) {
		return "/thread/" + topic.getId() + "-" + Utils.encodeURIComponent(topic.getName());
	}

	public static String topicURL(final Topic topic, final int page) {
		return "/thread/" + topic.getId() + "-" + Utils.encodeURIComponent(topic.getName()) + "/page-" + page;
	}

	public static String forumURL(final Forum forum) {
		return "/forum/" + forum.getId() + "-" + Utils.encodeURIComponent(forum.getName());
	}

	public static String forumURL(final Forum forum, final int page) {
		return "/forum/" + forum.getId() + "-" + Utils.encodeURIComponent(forum.getName()) + "/page-" + page;
	}
}
