Return-Path: <linux-can+bounces-6549-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBzVKCdMj2nnPgEAu9opvQ
	(envelope-from <linux-can+bounces-6549-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 17:07:03 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07731137D1C
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C533E30297A1
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B03624A4;
	Fri, 13 Feb 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="qgbXC//T"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094836073C
	for <linux-can@vger.kernel.org>; Fri, 13 Feb 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998814; cv=pass; b=UjHY2+Yx37MG2fgXty5/OltIKbRnjs66w+JnpXXLlMCfOgbnqld/LakP0oJTcUxjrE5FlRgnFeoE23Jwu2Ao6Qjr32wX/XFRMMl4yRMrNk934j3QO7uaKwkcJK1o9ovACKd62V6rn6q86qCEEv8JnGeYLGr14dNOIzSSbI404/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998814; c=relaxed/simple;
	bh=wAZKfOMevmaf3rxqjVLoWpzy7dQ4NZDk9wx7avyNFW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbTJaDIejqHXBIRktS76ELLKB2A0t0u5wjzWEPn05tgvRMv/MYne2ZfNJN2FKqq3/wOKqoBpAZPLrTCB/HRn56RR9zMDFsIbeuw5YxSuJ0C+wOiPsM6Y86YEeUjTHQ+mTpcPs7GdfPgdeL/fqIEVAMW9Q8TP+a9f2yF40Y4gL5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=qgbXC//T; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f194e9a98so384322b6e.3
        for <linux-can@vger.kernel.org>; Fri, 13 Feb 2026 08:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770998811; cv=none;
        d=google.com; s=arc-20240605;
        b=cP9qhJExLcaZz7Od7ZcbQSYACNK/3X/VYmceJphR4/OqDcumasSmvRXU9XQYCqLT+W
         DDc3hQvwlaqmkS3AeGk4u+d/q6GqPJE/sublz+aqo1zeScqosN+sRA13msTW0rA35w3l
         La03Z3qQ4nC276bh+Vc41C+uSi80UdYWeHcQndkRb4QYET9BnhDqRITBkWAcxZQAa+tG
         ftfJ26+7gcIxdqcQGeS4ozM5ZQGWRyBwo+QIO8KYWKbGeIAzIR2qPUmRu9sRxcio79fD
         fxg0g0zFGbfwpbL+NaL36nLSaAxYL9byXrieDUsk03NkvaMoeEGUNLqhXZqYTDVjqGtn
         Aoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wAZKfOMevmaf3rxqjVLoWpzy7dQ4NZDk9wx7avyNFW8=;
        fh=0N0Zwok0Ulq4meK7RnWsU9n1duFTH8kTg+wmJm+2Rv0=;
        b=e5dKnfUDwsBLlRSEnuWLcBYk6Ue/vn2rCGvvxgp6Qw4a1/t8OuxytCmU7RIeoJZTVe
         4wxjnVnccRiBYTnAkOXYwr6B8RpYdQOCAokKaDXkkgdq5lE2eJZt6xBX7cxm9y7uU3nz
         c3dMpeXEOlMd7w9LFsg3atR/Uf6mViPzHhwyqCh2nPUQil4rfVv117x22kf/ZmvOD02+
         vf8mcdyNs27M+aNDUjQl0CscMxwrgQJHPDSsyyWd85L1d7uo51Cg9SiSbFypCnV1BWaO
         UKBvs1JVAXNpeAcSGS1Nur5lf0AYKzFJaVuaUlsCPYjNzGHwnMNjJuXnxsVvkmmzK1W0
         QbDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770998811; x=1771603611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAZKfOMevmaf3rxqjVLoWpzy7dQ4NZDk9wx7avyNFW8=;
        b=qgbXC//TezO0b9fXdEYrVShftHOwf/fGUQzhWfkWKYQoEfw1q8JOLRa4StKLbehAcE
         2zFRHS+fiLfHq9fQa6fEZ/QzO56r1DEQYnWn9yk5ND5zOMuRFUW8zFSOd1tkZW0+LvIs
         Y35xkP8nH2odxTGRgCLMgD4T5EuJn2qnVwSnObpgNONzcblRq85SUMmIZaDCPExlg34E
         XM32NIjytnnE0CsJGo6DFz9UDAm7JCQh6VZ7jbP8SimFTUF0dGZ1q/PjX01QBn4f3Xz7
         bbMKo5qpBBu8L96PSme/RXk8oYmKyyYwEAl/Gl7CnZt/CkEEvG/YNIfAkGVAeZUI5nOJ
         TLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998811; x=1771603611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wAZKfOMevmaf3rxqjVLoWpzy7dQ4NZDk9wx7avyNFW8=;
        b=IkK9yusI7jdTrZIhW5u7mOCTLqc3Yi5IN9i2RiG1eNPhN5IWZrCwJK7SAsnm1Sfn1s
         s+qV88lJtXRlZ0Kde34PPuexGHu+hJSom7/tIcRqiIGkUCJaR6n/ERmhSaRWyoCYKj0J
         9OcGxVdEr4EhyONKniB2T8us+3ZwaiPDFgqDRMM+YaPXG0fQHUJ8JJDvISO5v+41wwIQ
         Wb0KvLeIW16083zxxCwJiFyI28bKoRNzXYhEs4dgr+ekFQjQjsfyr90HCBv1lk77wSfr
         V3X2qWHUj+YvoXUZqnwRCurqixkrV7wdceHIPZjQhcFoVOLbTVnlNVqtKSX+qPAgBowI
         jVqA==
X-Forwarded-Encrypted: i=1; AJvYcCWEQdF79d1Jns3uXupkK1CgDIjpmbmhRPrR+DaMiMxBiN9Wg7lVHWuj/IftqnyLSqsGguFbRnTc3PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUziVv1q/0armhqWj8ivBZrpKri/rbcK/D8nQ1MLI1fz/LnJm/
	S0LBBw7YzQc2gM/9Yl+aO5H4WrHtVZXhI8KPEaP/LKlLqUBYmdMRPDkXbfP178GrugHAfCC66uG
	J2PDZaRcF/MjPzsRjgKwAe1f7oYKnL3kzVI+IpUV9YaYeaKZsHNsW8L+ZJA==
X-Gm-Gg: AZuq6aLGq0ivfydaFiBXDxAVsRXIwHm/wjBViWRnKIeKs9v8A1wRbrJE72Z2hKWehQt
	24x/g37ajxi1FIgQxg9m5IPlAjJr6qOYfhUFKCV+XEK+JmQA3AdQVwde6zbl4uHYFP/xNg72Lp0
	kD4UGNgOYJj5WaCSP8E2q3yBPWuK7Yz3WA8Ki1hRuVQbuG9W0HTgfKigKtGcS6SIp9BhL2tXW2i
	avCA98pfjdZtdMlSUbNS55Bo1VL8A/iju4EKizM0/C3sp0ew+7OOjEKC5PPxsqeFb9jy0TaFXHI
	xGZ2UmpKHwnpCpLrPNQUi2j6NauxKuk22fDqcXD8bcz9LpTIAGr4vPbYdEYdvbxG6D41IfVt
X-Received: by 2002:a05:6808:4f0a:b0:45f:1747:ff52 with SMTP id
 5614622812f47-4639eedb4bamr1191145b6e.9.1770998811509; Fri, 13 Feb 2026
 08:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210035929.3490155-1-n7l8m4@u.northwestern.edu> <69ddd9ac-a12c-4680-9969-d5c45e8e5ffc@kernel.org>
In-Reply-To: <69ddd9ac-a12c-4680-9969-d5c45e8e5ffc@kernel.org>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Fri, 13 Feb 2026 11:06:40 -0500
X-Gm-Features: AZwV_Qi7uXBJNMtIqvPsnD8JkvWjyLD1Uto_gAzLbGM7_MKjawCMoc7cgZhiPLY
Message-ID: <CAMFT1=b+hLN4Nnn7j004_6Wza3huJH_Yu7XPJ1R1qvy4+_W6qg@mail.gmail.com>
Subject: Re: [PATCH] can: esd_usb: add endpoint type validation
To: Vincent Mailhol <mailhol@kernel.org>
Cc: socketcan@esd.eu, "David S . Miller" <davem@davemloft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6549-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+]
X-Rspamd-Queue-Id: 07731137D1C
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:01=E2=80=AFAM Vincent Mailhol <mailhol@kernel.or=
g> wrote:
> Instead of using magic numbers with comments declare a macro:
>
> #define ESD_USB_EP_IN 1
> #define ESD_USB_EP_OUT 2
>
> and use it throughout the driver.
>
>
> This also enforce that we are using existing endpoints while being
> more concise.
>

Hi Vincent,

Thank you so much for your time and review, I'll revise the code and
send a v2 version patch!

