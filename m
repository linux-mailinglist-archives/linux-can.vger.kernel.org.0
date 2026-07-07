Return-Path: <linux-can+bounces-8018-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cJHbIfWTTGoCmgEAu9opvQ
	(envelope-from <linux-can+bounces-8018-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 07:51:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEC7179B9
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 07:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dynetrex.com header.s=google header.b=JZMDFh3k;
	dmarc=pass (policy=none) header.from=dynetrex.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8018-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8018-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 502383010EDF
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 05:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DD1CAA78;
	Tue,  7 Jul 2026 05:46:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7F318EE1
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 05:46:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403174; cv=none; b=F7G5nXg8ucOW83sw7vwhLQ/zYh8JREkR3Or5yPXeoyldAVxU/Dof0b8qHoUXMtKS1KIe6N+IYzP3QMvkyE36wrkm19LdW1XtALmfIZ+wo+NmU2BmYHHh+H40bFTPfFS5B8P442DqTmm4qqo+pyN6FqY/owWlYnYzWGyJ2VHMUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403174; c=relaxed/simple;
	bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=eZjkrw6wWcPO+9Gu1w/emwWtFLqoXLFiD7XPyc3xq7hzI+afsZ58wpkyyYzj+YmLkDk7X96rZrmcBQMpEK6cGnEmi+elx5dU/dAKj8SorbfmTfg08TgrX0dwTmQUBBSdS7RD4I/KJe74C80XpAMLNzZmgGU2kw2ZMMQUgqgJk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dynetrex.com; spf=pass smtp.mailfrom=dynetrex.com; dkim=pass (2048-bit key) header.d=dynetrex.com header.i=@dynetrex.com header.b=JZMDFh3k; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845c92bc464so2695745b3a.2
        for <linux-can@vger.kernel.org>; Mon, 06 Jul 2026 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynetrex.com; s=google; t=1783403172; x=1784007972; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
        b=JZMDFh3kpGLPHRBp9VBMsARSCoWugReTaRb9GlP9teXxcQtPJs4C7PwQM83u9htXyn
         QH1J1KbqGsjayU6yJt6fwVvhbNUkpsUHkBzmtscsZuku7bnc6KsNMoa97lNY4tpaYYdB
         z4h4MjhKL87wt8NFZeM394z+qVoFRKvT30pgXyPXy9esbPfmktHKJ3mryyvq4j+8DYpJ
         IZIvJ8Cgi2VBSWK6KDFOUmzXML2enTv6Ow+wfU1tGHoGkivR2tMD5KBnAZAY5RLSUIbY
         M9eKPijBT3Mr+ED6B2PostArUALcusZ3clRePgE8JLLLrABVPI13LC9n2zrL0J0zUH2L
         5CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783403172; x=1784007972;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HPhfOG3J+AvG0gshIvUmJB9sKoFyNn5WUNK/lApVnk=;
        b=eFXuCc0cOHCZN8miKEVqJENrDahNhk+Oah8Am3O12IOXl0i6sqgI/TW3krSxYd6xQH
         a06Lni1LT0vRZ/Jn6qu+OSn0/0jKX02dCa3uyw6hmzZ5doxuFo/3NcsXoK7sQhLmNc/W
         zVbKBzyEI45oKKFZKhZffkdQi4Xu8mGgTjVApdRT4KdWdHyKMoON6rKrhImO2PoqQ9EW
         c5OnEIEz2+sxM5t3mc1OhIf/KJHVXFgeoNKqAZF1kLRYyKDSKw3YWgTCRQQ9lag0345B
         MfrOgN39KtAjHsVlLR723O6JUwVdHMO3uxV3p/wlUDs/vGKWn9tKOOJ23UvEAQwlzsRz
         h6Aw==
X-Gm-Message-State: AOJu0YyP/gHtWeEXloI1wAv6BmGvjIQneCcz/F3x9ENS19rcj31ERdDm
	bapXdseDM4PU9xLPu3iWFNzEYV9meLyQRVDqmkAvA5ncvDizMPlNwJnZAruUCx8TDCxf7BJqPbU
	g7FrhyAhpo7nRTBRaO8i/hQ71GNwLoVKV64QQNA8ZckehpNHATmoClXL0D0WPqRiiSkE+uXdvI3
	ay/wJmj3naRUGR/PhZw0Gaxl7jgBx9adz5JARY91ZLJfcHstk=
X-Gm-Gg: AfdE7cnTOaiK4mM6zX06SddNCxthqa1EyUHEIRrgRWkSgidJzTRrPy8SDM8mPIruB89
	BW/Cfj/pO/Wbqp4GHEAPbar0pXeP8YTbxHmj1spj1YfxwcZKZj/0xiYIO1ObUrW43AN5yhTU2rf
	gxhmAfmGRs87R4hTSWXiX43Bq+wPDK8f0yb7Xw5LPvNuVP219bYbX/T2+3DvibqiPadwCNEVXlm
	vNTMeDM1fLHuQ2gs4W7u3KPIMUCjNcq0wqQLMqB3TtCaqBqG58Tk4WKOwcwJKmtx0MIcNcI7jNW
	TIwxjGpg4LcpQi5C3n200mACtTZLIZ40qUwwg3q0/g0UkloLOTZxeeBTo/6qnt353rpmoc0WZ9Q
	vyhebu1PbjmZRMQOCTSEVtogFYn7+SjhnFefEVxs8K8PXlxvW2SeSZD3nAQZF1JF60Rm9To2bQT
	8eHdlf2MF4IjWRPLHlsnP98JKGKtsf
X-Received: by 2002:a05:6a00:2e08:b0:845:e04b:565f with SMTP id d2e1a72fcca58-84826cc57damr3429141b3a.14.1783403172200;
        Mon, 06 Jul 2026 22:46:12 -0700 (PDT)
Received: from smtpclient.apple ([170.203.201.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bd1078sm4766048b3a.24.2026.07.06.22.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:46:11 -0700 (PDT)
From: "Dynetrex, Admin" <admin@dynetrex.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: [REGRESSION] can: usb: f81604: TX broken with "short int URB: 9 < 12" 
Message-Id: <A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.com>
Date: Mon, 6 Jul 2026 22:46:00 -0700
Cc: gregkh@linuxfoundation.org,
 peter_hong@fintek.com.tw,
 mkl@pengutronix.de,
 mailhol@kernel.org,
 stable@kernel.org
To: linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dynetrex.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[dynetrex.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dynetrex.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8018-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:peter_hong@fintek.com.tw,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:stable@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[admin@dynetrex.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admin@dynetrex.com,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,dynetrex.com:from_mime,dynetrex.com:dkim,dynetrex.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7DEC7179B9

Hello,

I found an issue with a patch applied to the can/usb/f81604 driver on =
2026-02-23.

https://git.kernel.org/stable/c/36ead57443146e6b730ce1f48ca3e9b17e19a3d2

The patch added a check to make sure urb->actual_length is not less than =
sizeof(struct f81604_int_data). The issue is that the interrupt data =
from the device is 9 bytes, but sizeof(struct f81604_int_data) returns =
12 because the struct is marked __aligned(4).

This causes valid interrupt URBs to be rejected. After this patch, CAN =
frames no longer transmit successfully, while before the patch they =
transmitted without issue.

Each transmit attempt logs the following in dmesg:

f81604_read_int_callback: short int URB: 9 < 12

Please consider either removing the __aligned(4) attribute from struct =
f81604_int_data, or using a constant for the actual wire packet length =
when checking urb->actual_length.

Kind regards,
Alex=

