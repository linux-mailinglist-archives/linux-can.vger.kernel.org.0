Return-Path: <linux-can+bounces-6540-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNV6EuF+jGl9pwAAu9opvQ
	(envelope-from <linux-can+bounces-6540-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 14:06:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E3124A37
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 14:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2CEF3013EE7
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D5251791;
	Wed, 11 Feb 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PshgpcPN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6693316195
	for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815196; cv=pass; b=rqVNYSmsCx7Xqwm2PfZRnic5Qepbd8N8WJRO/hHZnx9TZm9U6OopmXkhcx+GHTXPkz77OAwClLPT0lrsxJYNlOtWova6Q84rAaUhFhdAT4xLMnuTF4imtum7CHFWMri/S0XukBEVqDT4TI3s72A2K0zVPOR2TA9F7fAoPmhJ8Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815196; c=relaxed/simple;
	bh=TFb3czZM4aDFD2j8L5adwaTUwIEAUKxhszw3OcTcRog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBSp2ghEOMc3lXfo1ptfI+UWYT9JHQOI7SC6YM5irtrnf+wzxTaJofTRJmeuoTBb/wYtEG4z6sH1+XcrbxzK8rN2grxmug9CNfH8eLaqrIPDZV5I+748O/CkAb+gR5Z+Ma5rbzgy7ZKzHa2CJb5W66o/oqWgL1S4TUUDln5aClE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PshgpcPN; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45c962424daso1950616b6e.2
        for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 05:06:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770815193; cv=none;
        d=google.com; s=arc-20240605;
        b=UDEoskvxZDsnFaC5XAMAc5t5RpyEm+RUPBSqYNxtr7BvHLS2rQHzBqM5lk/YEh6Ii+
         Ao8meVJhvo5QQA8zTW1nMjTGDAmIWMtKiTvNGPYLtMjHWM/rrFJ12Y1p3yY5KpMOsG91
         oqqHZRB5uyCwhq415OHMX09G1Kp2fOLycqVRVGabHH/yZ2QIEOxOmo6zghCefuqwY+Wl
         hn7oUpl2JpjVXNPjME+pTHLo/Biwy2PJHALJvvl6z69Ba7OgSeEZ/mh4PkoIO2MxcYbb
         FUQiFl9tk5nN8RNl4uvhCdyxWUaS0lTQDH5e2TOS+C185oLVlONVcaPj3NB4BRkQP4Bp
         DAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TFb3czZM4aDFD2j8L5adwaTUwIEAUKxhszw3OcTcRog=;
        fh=dHdZTjTVGnRx+oM4KRmptXagV7dLixF3P0TsuMF/a9I=;
        b=Nz+k3TPo1QFycU+GxSXHNBMFHmGKyiR2qQEnXlInT625BVZ/mBiPCdDjNpGgDGB6lC
         x+K13RJ7tZ5qMAhPP9k5XOs9RIzzrxw2CwxvGQwVXaAxb9BGLTNf2Rk/L8JlhBdMU5SJ
         ACWwYJl7NuELDsbge37t2iDnilY2ZcfBH60Cpgi1kMdGNBy0/HO+eteDtB/SRDqCzDEl
         8ZhKv4UyNz8Avzy5bOldP4mTzKGIMBnMaolaFlQXjk6wE3dbcCOLoKGcGp1q/1Etaw5o
         BmhAQF7DdyftTLQPRgjuTRuOmt8A8cInsGbm3ZCIhR3RGtznw5vktNVmoF0f98eT8p8h
         jXmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770815193; x=1771419993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TFb3czZM4aDFD2j8L5adwaTUwIEAUKxhszw3OcTcRog=;
        b=PshgpcPN/EIZNxgV/RPCEnNYdSm4kP0/qiYlxnZqDEjXNbgzJycPMpioWHN72AiExC
         obgknqQTabvYB9uSqIA1qqyU2++eEbdeApVWIZHLYG/D2NyFUvrZXYsFJkNL/yw3Zfd7
         iE/L8m7Sf/k14m+QDoKaXS3QVSCQNt+TG6ESQZ4UEG0qLc8FBmUTrpcEcsyzUUM/XCmU
         YXJHOb+U1WRB0wN4QAMpztHmltEt+05LQY5WJjRLRePltg4pVXNOp19GsE6Qs99L3OM2
         yEDBkNhb0lH9Xc4ErZXqc+kI4xv+n8x2CzQ7/VbmQvYEaZW5Ox6yQsFAwnyhOrLGgFBP
         qGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770815193; x=1771419993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFb3czZM4aDFD2j8L5adwaTUwIEAUKxhszw3OcTcRog=;
        b=IuLtFwhjlFmZMdF3AleEHQsTSgaHBTLvRTTn8nzrcAxZExMquJoRLU4uQHkvhBT3FE
         5ADMQiBf2kI77QJ1gF9kS355+LqTrkucAYPdi+9KuCh4YeirKeXsPAAWGQx1LJK4Um7d
         D6NTKDMzyMb2H3oo6J5MGnugOSiDiKBGcUUutwxSoKj97y6nw8CSFA1tdSM3puWfIJ/B
         uLG77rNNfk3OvMJsvlxPae2HMEOGjhEp0ay/UjotLxxQ2k92qgWCVQ/y0TYyJp/YIgzP
         27BdmhUnFJSAvO7zPtT2eee3aQZkg1DLMJTPG7xELmP14b46COnYAkjEu8LHkuiofkd2
         3UWg==
X-Forwarded-Encrypted: i=1; AJvYcCWamBtHhL6o6+3/5L8pUmhoKQGu72Q6SIc4tPTFjje+mNPWkMQz9DeoYtjpMVOHRUR234Z12EZIRl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWq4Z+gLWQY7Rlwk4SnZfWmNgIu8omQMHOfyuZdpAiMuVq7by
	G+GZ6AQrMfPXcUSdq+cCxU9qYbH12sG6ffGBtaN6dVpJaD7xLBzWDi2ua0qPWxTznf3kWJ17lHd
	JTKnlUvDhsHvI7fWRCCZkadjKOwM8prbeX3F6
X-Gm-Gg: AZuq6aKqVhufaE86nPEpd3+iyhCG31hM2pqf2LrrzmwuRaMZ10n+ff1aEkDoX3wumXG
	ez4ht0n8IdcfCIuWN6hF/8GeF4N/ZsM8xZLahxGc0AklZ37EBY3MYLJmfmwq0gZwiIGPDxfAyJn
	lOTPumJJNE6jARzu0vdq1AqM/LuxDI6ahVmdDZJnjDegNJY7vAlftSsipgoEZ3IdgxnddHJvxIM
	/UhMlvBaXmdtV0Yn14gP4PSiugTfypXvmVlYEuvv+JD38J/zC2rEosI/oipzC5DAM76wo/Xe1zG
	B4kDBg==
X-Received: by 2002:a05:6820:1610:b0:662:c3d7:4614 with SMTP id
 006d021491bc7-6743b2c813cmr1007189eaf.83.1770815193544; Wed, 11 Feb 2026
 05:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211104029.83860-1-oneukum@suse.com>
In-Reply-To: <20260211104029.83860-1-oneukum@suse.com>
From: Szymon Wilczek <swilczek.lx@gmail.com>
Date: Wed, 11 Feb 2026 14:06:22 +0100
X-Gm-Features: AZwV_Qg7jtsWVMD4PFrJH52i_97vm9GnYI09PxFJhb4tzD9UdByTleZ-HF_GepM
Message-ID: <CAJRoVwiF4iXSft+8WY_Mm6oZwcNG1Hi3Sx7tGWFVFJS1EBZiuQ@mail.gmail.com>
Subject: Re: [PATCH] net: can: es58x: fully try proceeding with partial allocations
To: Oliver Neukum <oneukum@suse.com>
Cc: mailhol@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6540-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[swilczeklx@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E5E3124A37
X-Rspamd-Action: no action

Thanks for catching this and improving the logic. It looks correct to me.

Acked-by: Szymon Wilczek <swilczek.lx@gmail.com>

