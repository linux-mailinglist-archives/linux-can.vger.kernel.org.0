Return-Path: <linux-can+bounces-7730-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHjeGMJRHWpfYwkAu9opvQ
	(envelope-from <linux-can+bounces-7730-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 11:32:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E685361C7E0
	for <lists+linux-can@lfdr.de>; Mon, 01 Jun 2026 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB7C304775E
	for <lists+linux-can@lfdr.de>; Mon,  1 Jun 2026 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72B346E6C;
	Mon,  1 Jun 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEcIEGtq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D8390989
	for <linux-can@vger.kernel.org>; Mon,  1 Jun 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306116; cv=pass; b=YfukfJ9Ki/kMs/0P/OBUG7/Tk+GpWhKNkE6c7EPIlu+x0EE+6eM9D18CBUY1/kuUPM6kwnMOKh6utB/eQ8EO0oHAROOaDa2N0UBwD4tqyu+zjadd/tbpfxkuu1piWo9cqX6/OzsxKtuRfYlToYouF4qDnTNwevVvat9djiNA/34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306116; c=relaxed/simple;
	bh=sMNSTqnAGE6OtlcQbVyNwTgz3MSwH0QLpQ6RcYlIZc8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rzditkoFiTel82o/n4ND1CAfaeETIylUQRrvfBlvGUS2pkt3vI6Sxf1dQgXC+5s4IZFIr0ZWByjdRBpob2RherXOuJW9bt7fRqVWgKOR5e+vrQvcPSSdRbJdSnxHBI2EH1QeYDyXtY8g9QqK7S3MfJKjapQlPSe2O/5dX91cxl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEcIEGtq; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e2fc11088dso8461397b3.2
        for <linux-can@vger.kernel.org>; Mon, 01 Jun 2026 02:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780306114; cv=none;
        d=google.com; s=arc-20240605;
        b=bKBneClJorY+LAite5pLkSVfKcUcq3iRvbziHAnVujil2eMeQRsqyIsDHsJKDwks3Z
         3mT+mn5HJQIUv6Z3KPXXmzVantGTlJ3EW1POsHef9dTlwQdJ55b0WP+IQlrTPARb4AX2
         4ZvneAQLKkCO7hjMYAVCC7UOUkmms/EVlPgZ2Ds7IF9rAwenW27HJFKELqent3m94qi/
         UWV6XxNlDFriXpEh+1e0VCcsF2VvtmkZVbNRGwWTIEVqKT4jyk0FISmxjZLwAm7IdaUD
         SzWRXHxA98LKTpr8K5z7CKY8EJdbdG5IKIilZ8PSk436k+0WGmdFN9Wx4UzgnmgWjMZn
         njsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kuWVGThnMqcNASzARI+8ybNb9M+SnC4i/w//xxYau3g=;
        fh=KjaHxQj1VI1xuaHvcBIAEgWhmqMaZ3zFhNfKurkZcUw=;
        b=WORsWMzP7n5eaJ+2YnaI9vtfYB1AuaNDJxAbnNmPqU/4Q5iv3sOehAa470DtfqZewz
         PVzsibpkI4KW9sF7I0YWHCCXXLww0YZXVKbnWAZ0BJ9VSR6YxyFqrLJTds3KzwxcjBX7
         gNFuBQHqBnJLlG48wSH7C+YPDCAbXWhL0YbNq1aRKuUxyIDisaS9VxNUmtqzepzZzH9W
         OVYu3J6DRbHDVqg9TfwWW6e2P39BvxJPbs60tTL+vXclS95phtILrrrry5jnbwNg53Pg
         VrjjDXJYdkXzMNmd3wEWQChINLohqQ3oAB0+ve7UJQcR132hO60sx/MtbI2MkWXAzCsH
         vgzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780306114; x=1780910914; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kuWVGThnMqcNASzARI+8ybNb9M+SnC4i/w//xxYau3g=;
        b=EEcIEGtqDS3B81nPNbQ+OP2yKoGSNfekfJJQy1SUF1PhmXt+FIl6TvT+dNUFkvtO8/
         xjd2yFz2FHwp1kNxeFaggLKuTU1z6pmZVHDGic2Df+M/krMo7HjbPd5xFGX0iJWKXGWl
         wyCcKHsbv1OG6md7Ql6qkmqzrunj8A+zsQ2AEsg5mvS6XRKZURuBcFHLy/jTl0b5tIO6
         /FDkoC/1ojRvSPbYwfCrzCh/eoixkENpZe/DQw4jMwRiGXST0djxDElVnSThIV1YOx/m
         AylUrYhNg7vlsY5BPLlCbfnL1eXjs2XAdItwuQhWP7IHJR27/4o3O+8rArq18y2fKabV
         H3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306114; x=1780910914;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuWVGThnMqcNASzARI+8ybNb9M+SnC4i/w//xxYau3g=;
        b=n8fxPG9EnCW9hGkDmiXusVTroSecva/8c5T3TfEENid02R2UZjIA54ufmBlm7w6714
         aL85QYX4FhV5ApA5fHjA304XDJZWbQoxUcay0qbihaKuQ3rWdl7yQQUrjLMOYpxQju2N
         PAE5G+vp5z9q7VeKUg8dTf9wtFaolmSWPREbK2QOH5+UHbBnd+z8hAuj1jcfqoGhKmDB
         T5QJ2Ayt4ZVHBYjSm9ohdlvqojzTr1/XoDjVHpumEN/oT7d1+dS3+skIyNlRk9VEal1h
         CEk1yG01TDN1wpwzYJih3jhFdMl+UgXIcuqjDX1hN0VqR4FxCJ0KSIPTkSyE09FxSi7s
         XuBQ==
X-Gm-Message-State: AOJu0Yz6fTE4DRvcN0b877XwGIGjJQAQgb6YSg2mN9mHFpBiElg702xK
	TGkIX2mpXjwulllw6wp+UHh/Q+vdh1uPvidz/wmGX54hbCuSL9F+NzHXt/7VnnVMer3+ZLdee8E
	hqo49M7SPCS8IdwqmT90o4a7ijh1ffJltj7Rt
X-Gm-Gg: Acq92OFHvmQfClT7pUt/sPIsUHLs7ZAQcfpiV7fmX6aXRRyw4DoA5527ooyBPcLCsTb
	Xtr6X5pxSS3d/tjKuqehZ++su+b0lsuTc5NADzy1UqlNLKnpmPnbTDiUZbDfm4LurOnIx1PoitB
	+1/hkl7OdnknvW9WO17kEq0mubzC5JNKtv3deImEiybmZLO2vihm9Ssp54jrs44Zk3b2iSqj0Rg
	3L7BGtf7xFeZLnOJ3SrR/Dp+i20v/MM74yXKi7PsEV62ZZ9kOmDdpKb2OsTheXw85Xl8AQMnwPR
	wmu9cQuLrJ8YtuJbkqx/
X-Received: by 2002:a05:690c:48c7:b0:7db:f1b4:15ed with SMTP id
 00721157ae682-7e058d32e86mr87271397b3.3.1780306113933; Mon, 01 Jun 2026
 02:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Mon, 1 Jun 2026 17:28:21 +0800
X-Gm-Features: AVHnY4Ib4ybolJPWfyVZg9vOM9dWwnSqZOsco-kLq1GK_HFVdC3Xo6MKXlPHkIY
Message-ID: <CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com>
Subject: [bug report] Potential atomicity bug in net/can/bcm.c, between
 bcm_notify() and bcm_sendmsg()
To: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7730-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E685361C7E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Linux kernel maintainers,

My research-based static analyzer found a potential atomicity bug
within the 'net/can/' subsystem, more specifically, in
'net/can/bcm.c', where bcm_sendmsg() reads bo->bound
without holding the socket lock (lock_sock).

This potential issue is present as of git commit
eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.

bcm_sendmsg() checks bo->bound to decide whether the
socket is connected before proceeding:

    if (!bo->bound)
        return -ENOTCONN;
    ...
    lock_sock(sk);

Meanwhile, bcm_notify() clears bo->bound under lock_sock:

    lock_sock(sk);
    ...
    bo->bound   = 0;
    bo->ifindex = 0;
    ...
    release_sock(sk);

This race could potentially cause 'bcm_sendmsg' to operate with stale or
invalid states.

Best regards,
Ginger

