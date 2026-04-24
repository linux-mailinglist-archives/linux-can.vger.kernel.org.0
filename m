Return-Path: <linux-can+bounces-7397-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB+fMpyL62lBNwAAu9opvQ
	(envelope-from <linux-can+bounces-7397-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 17:26:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D2460C17
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 115D63008522
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E243043DB;
	Fri, 24 Apr 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdNgmecG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC63033FB
	for <linux-can@vger.kernel.org>; Fri, 24 Apr 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044271; cv=pass; b=I1mOW87LJrjTzACvkLJZVVGMOBijZrZFZmlHleyRajgZDy/RonnWkp4DQekjjpDL3sGO9tpGU0+JuzVKeExUISQZUwrLSsA9XkqXd4wsVqarugjbWmVjZQ8MbHEZ7LFdKGJ4EwnaQz5WemCS/Wy+TR4vSdLtbxbOcD5+DECEKvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044271; c=relaxed/simple;
	bh=yH8+Sry6dHTFa/pt3SEk0ESCeEwjtApOsyPrSEoxtLE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UuGj44L5/kaCgnGxlgmlF+Sni6P00Dmq3ffhNJdSd5MjSIIz5o2o9bNDxx2ajt51LyDEiwPTMkIb6SmNp/VNla3RgoDpkoCbVyDVJ5MZkb+9lWbfzjPmlQt8v2NoW3JvEnH/wZHO7Te7EuVjJ5PyLT2X99IpuqE7yDvr6mfeMmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdNgmecG; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7b4ee3a88e1so80640737b3.1
        for <linux-can@vger.kernel.org>; Fri, 24 Apr 2026 08:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777044270; cv=none;
        d=google.com; s=arc-20240605;
        b=eEBiO1tozRyhnBik1gpjT9FdX2DoFS7maUkMkFpaFmcgixo0zI+g7eobg/mmUB05o3
         6/X6+70qXgJ8VpXoLqHnOGbfHoejJDdrVoQDwcnC8qlFC3awUhkl4k70xqgDmKI2pb42
         kmpELVVq+5rGg5af9tc+rQ3f8GNmA/oTCfmmLN1bGOfolEqF6f8I0cEHnNk4c5gV03tJ
         BxOxl9KsEbOkXpJKEcJxqx9BPcQNLn35IGAdVR3afdwOsoeMOYg2ZN60MrtF+PPeQh9X
         ndPSZsFil1ZIs+OlbK5egzxQEHjGwj/EMcZFVyJuH6/7nM4vJ2LFObIAn5mFAn46apIQ
         X0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0mqOnHBPqmI9jYLsGKachyOemePYqbuCMH8FskR7d/8=;
        fh=Ps0kqod93ftUfdf1pEsAyz8+M9Cwzr72PDKZWQmynzk=;
        b=UsUkjuOus6ehBHuymm1pYpTYg3JibXeCHEHluwO7CSDcGiRNztdOCvW16mHL2RatNQ
         6kFDjvR6CXKwfEHHcRMdBsElDKjxG2f402J/Wk9KO3BtjsbD0V3rSvZuIpX5uYO0aErh
         gx2os98DHgvEpbicBOcyrNv/kpXgsQfbvbXScXjCadf9Vd4hL+zVkWdUNf3vr2MqFoz0
         kOtenYAgX8E+3tTD5FL4qYFs7lFpg0kxkODev1brmxNl4dZMIcmCN5PR++yi4qE91gup
         jHF7+M2Plix/wfeTVeqLSSNrTxeNRtF6D4eyNVLVILm24YuLY9K1qwzgPqw8N9GBC1Da
         cVUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777044270; x=1777649070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mqOnHBPqmI9jYLsGKachyOemePYqbuCMH8FskR7d/8=;
        b=mdNgmecG3Y294HHnEZxB94YN/kE/VBsu+xSaH9m+rXMlL8gTYvr13uJ/9J1yKrp9tu
         lh4pHUzRhrt2UNP0lMG0ZaBPYV+Ocbifz/KPEdYmvbgewdAUkMp2nHfviX9yKNZxhHWg
         fFP0hj9sn0JAqwWdV5O9YZ3YOSK8s2ZjEoZFx/fx2c6lS9rIjdCZpYtfKwtg82vzwuTK
         jzs/Te5e/pYj8xxXkwoVMRILbvzH+zFH+tOKfPdu4mX3XK0J2eYeXAuug0iGrt8eQr4E
         lMZroZa5wqhN8V6QzKdbJHSFhpJa21hADysf4+NvfjjcG/XKgT6NjUS/qKUQBgIpsbzx
         UPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777044270; x=1777649070;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mqOnHBPqmI9jYLsGKachyOemePYqbuCMH8FskR7d/8=;
        b=e15eFZFAd21AtK4Bj5esPLmkX6iIiYqzaC/wMUA8nmv8Vtns7fRCVxC71OE2LSqD5r
         INFD1Pg8T3df8bl8bYr4M1KdeB7r49+BOSbQAVYWSDmeDY228/PaicvPxNX1z8QQqThr
         2pAjIRr/x1XI2hZTZPMs1yk+ZxbDhnDuojGbkS/QaxLI/z/3LP8XjgMS/6fpMSGxpyD1
         gJTTqVjYFWXbZk2qtCTrpIFXF41IKD6TwXd3W9NJXo3oJPifVlwFXdvIaR5YCY7OYpHG
         1rLKM6wqeuoQ/0L0kV48WlDFTQSl8qYZX/5Bx3+Qp+fvr2CbM1RkL/VZMvce56wdTjEk
         j3rg==
X-Gm-Message-State: AOJu0YyE+3MLE+j4lmRqS3NWPwO/NxWmPb5weJtgVsbJKc3CZPGoFoxY
	xvMiedl0HdUc/3/VIUGxiESUZJIGCJHP7VFYsrMueHAS78cSFLf21FSXEvdzjWl7I1Of4J7z7iJ
	cnNlbaxQ4XGTMBjlX4irPH914NxzVbIk=
X-Gm-Gg: AeBDievBQypH0JN8jJaJTWEXZRsJ0FpBMJ76D23njLBL6qJDJocTEmtT1CQwE2WGPGK
	/e6tr9gJAAsf93eaCHLgXZS7o0UpgyW5L21bxRdpXH7OPnOzux/pwOzRMFXfW+XjWug4j9vcg/m
	KriahvcshUF+vElPhyncaXGFIlkvPEgtKS+9Q0iMIfHsj+vLC/risnes6aTbbq6S4orvhHSJ6Ye
	lAXE3qtsda4/FphPup3A71K//y2bH2D3eSe5Z0ENfFhQKfSvjhzdTVpb9Jl8BWyVikR0CEkep9I
	YpNUiyluHuxkH0tkfQ==
X-Received: by 2002:a05:690c:6e87:b0:7a2:80a9:93d1 with SMTP id
 00721157ae682-7b9ecf98abbmr329086097b3.25.1777044269745; Fri, 24 Apr 2026
 08:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 23:24:19 +0800
X-Gm-Features: AQROBzCBmgD8T8SODZI8KbqFyhfJ7gmKSk7y4Nr9-oZbRHPS2xG3IzyvMvlPDV4
Message-ID: <CAGp+u1ZUNzJaiGNBrOoHARe9zZ=UNgpBYmmgTTtgywgq6tf8VA@mail.gmail.com>
Subject: [bug report] Potential order bug in 'drivers/net/can/vxcan.c',
 primarily in 'vxcan_dellink()'
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2F0D2460C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7397-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential order bug within
the ' drivers/net/can' subsystem, more specifically, in '
drivers/net/can/vxcan.c'.

Kernel version: long-term kernel v6.18.9

Potential issue:
T0:
vxcan_dellink
    --> RCU_INIT_POINTER(priv->peer, NULL);
    --> unregister_netdevice_queue(dev, head);

In T0, the priv->peer field is nullified before the device is
unregistered from the kernel in 'unregister_netdevice_queue()'.
Considering that many other kernel functions rely on the existence of
the netdev and dereferences 'priv->peer', e.g., vxcan_open() and
vxcan_xmit(), it is possible to cause null pointer deref in concurrent
executions.

Thank you for your time and consideration.

Sincerely,
Ginger

