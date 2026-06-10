Return-Path: <linux-can+bounces-7820-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F3cZL3meKWr3agMAu9opvQ
	(envelope-from <linux-can+bounces-7820-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:27:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F466BF1D
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hHinuclF;
	dkim=pass header.d=redhat.com header.s=google header.b=NRZ9uNZR;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7820-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7820-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4568F30A48BD
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD423446C7;
	Wed, 10 Jun 2026 17:25:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AD34676D
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:25:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112355; cv=none; b=YljY58dX0YZ8PSb0Uh76pMZcGQi/fp5xGLQb4wYQ9l/tDYH1k5tuyFSyxnpYXxPXQkfRtpJyjC4UIsArjUw3n1aPV6BPjOdcjaQgC2SxqGQ1Iz8gGUGBRUIhatdFLOtN8t/kneBVTiKMzqXx0mXTr7Pvv//ulB5e8xQTK7HDsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112355; c=relaxed/simple;
	bh=sKphK5qO0PT5ZVNfxHV9y5CWbBktH7wkhgytnS5nrCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QD9Qz4zIaN9qDhkmbRdbHsXS2hYe4YM8dD6EHTmcyds1FM/DdGAGVOoPyfonijcL3IV5K7UByHadZZnGkn1F0rkQTZD5QESraSr9vAtfnctWAc5CGBc8LnUUF0Rc84kINmjJ8Dd5tSVtZbbxPdwtJQf5sOrKi0gFXhnMC+7YNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHinuclF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRZ9uNZR; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781112353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2aMSZaCfoqBZzL8F7noAF9g5xEPkxMn+qkDrfHZZKXA=;
	b=hHinuclFymYWZ465xWTyry/MbvWfpD48RzoBJ51M9pVJ79MkrGBFnGNqoOyiBbD/xxo4m5
	EOFLb8WUjTO1qgqN66Aw2mbwG/zOr5ZcOGjrSYNwkXFzNCasfBYoUD+faW9aWIYTfXQgZM
	ueHer8VVwdhn5QKo2AY6FLj+JVvRk1k=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-AqSJOldYNYaM8tVX-Zbjag-1; Wed, 10 Jun 2026 13:25:47 -0400
X-MC-Unique: AqSJOldYNYaM8tVX-Zbjag-1
X-Mimecast-MFC-AGG-ID: AqSJOldYNYaM8tVX-Zbjag_1781112346
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6751c50552dso669988137.2
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781112346; x=1781717146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aMSZaCfoqBZzL8F7noAF9g5xEPkxMn+qkDrfHZZKXA=;
        b=NRZ9uNZR88x5g6NeCC4V37Dsw3bQpr/dxzWAed9lgTfyvD32FoNL2AGDHsjjTzezoA
         g2IASTxTLVNMmSjFqmz82QryDJA30KhD6RWESFKA0UPh4sNOFh9W1GYUPe9Imwcv6QQL
         ATlUGMtnCC8jhMQxjEsYNvBehL8wXEE2MHWl1feFRKJ8WiRHw8ZVYitRaSyzo6OLr8rB
         AtbMMxIfoKXa7r4TWLBDkAp3oxhbrQ3jqKuRdeytwa5s5/IWsxQCIXiEv019hADpSvve
         ptCkVOJewS6coxDwU6Z4QMlPgpkNsmYZyDMhjyz/PTzFZEwLk88v6ZeTnPgpcwztK65f
         6Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112346; x=1781717146;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aMSZaCfoqBZzL8F7noAF9g5xEPkxMn+qkDrfHZZKXA=;
        b=mv9ZAIjw8KDfzPPsjDfEckzvuFyJuP+kNrhHAnxyGSZr8QBUgdlcwhN9ZqVlD+so0h
         P25RmchIiLsYa2rcnua+F1KOkihkB7hwlF6Z2g4XpvUJpf786mjgDKBFvAjpzW/eX7OY
         fjiw1y7Cemvzdbt3z9Le9dDqevASPAZOedKXlryJXTD5A8jP9k6J5aBdJVyW/h4qFBan
         dWk7n0MkwEKFKE1s0xxsko9HYnqLsDLE52eBZzSu9eCgFD/OBApabSGV+zXWqDZz8nx1
         XIXJ5RWMeDBJ9MCTz0gCF6FPfBKFBLv5NVx52zXVdmEAnFPppmcQqZA17Wu7ptAMFw4g
         FMHA==
X-Gm-Message-State: AOJu0YxmAAnV8yP1sQvwltFBWBWpuXlRhZ5REfTLENRsLxcfC7b/7FT1
	3kZyw6xVrOS2CKeY7FAe1o8sQ8i1PiUXH7PpeyZ07vUEpGiJ9NP/wvGiNKDlcV2MZxlsTS9sEeI
	BDLUXOklQ9SfG4r9VmHDZVa2XaWjWihZr1atPOBY4yS7RCSymobA06lZjWIBf0Q==
X-Gm-Gg: Acq92OFe9b2hw505aZLmAB2B25y6EU3rlgx5J0BWkRAXtRXHgabL3d5C2Or0JrG+ach
	TW+9nLSfaSPjuELwN6lFGaV6ncpgEQ1jX9/4JEogFrN+Wv/VC4rJKG6MG5V+jkPvEhSlkYLoHbV
	Ui2aBS7wUCuPip0+/0t0pxQCiJ8eJIyDwjgz3qU4WSmOjg1RHv6ioS1r4v0js5Q2K245p167/8W
	DK/xwYzeMeASHbkdjQZD6MFTrbA6r26/JJnRw5RUo+hclnAtsaFL5QwN00FTIwq/KdsnJqiUcKa
	ymIegauSArvrxcmNn5u0X21HWuM0QKGOCcdputMTfhOJqYIPOkNo/L8uN2EuI01ovVvLDEw8pQ6
	hMaRgE1lEUvDrgMb74QYc2kpaGpz7GdzaFsrfT8m1wyZy8DwsBTLY4JDBMSHyP1LsYEStLbon4I
	RsvuaasioOmWMOvMudVz5h582BH8NuO2SNwb/I
X-Received: by 2002:a05:6102:800c:b0:607:798d:8083 with SMTP id ada2fe7eead31-719361e5d88mr6376790137.15.1781112346428;
        Wed, 10 Jun 2026 10:25:46 -0700 (PDT)
X-Received: by 2002:a05:6102:800c:b0:607:798d:8083 with SMTP id ada2fe7eead31-719361e5d88mr6376711137.15.1781112345712;
        Wed, 10 Jun 2026 10:25:45 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-93-66-125-181.cust.vodafonedsl.it. [93.66.125.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm2532946085a.27.2026.06.10.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:25:45 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH can-next 0/3] Introduce diag support for CAN
Date: Wed, 10 Jun 2026 19:24:43 +0200
Message-Id: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANudKWoC/x2MQQqAMAzAviI9W5gFFf2KeKhbN3uZsokI4t+dH
 gNJbsiSVDKM1Q1JTs26xQJNXYFdOQZBdYWBDHWmpQG98IGWIzrlgK5nu/hWiCxBafYkXq//N8F
 nRbkOmJ/nBf5UZMBpAAAA
X-Change-ID: 20260529-feat-can-diag-d7acbf5e22c2
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Filippo Storniolo <fstornio@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7820-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:urs.thuermann@volkswagen.de,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-can@vger.kernel.org,m:fstornio@redhat.com,m:dcaratti@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 761F466BF1D

In the current state of the art, it is not possible for userspace to use
tool like ss(8) to query open AF_CAN sockets.

This patch series adds the netlink can_diag interface for AF_CAN. Userspace
is  now able to send a netlink request to request information about open
AF_CAN sockets that are retrieved by the can-diag.ko module.

Patch 1 is a fix that is mandatory to the correct behaviour of the diag
module: the field sk_protocol is not assigned during `can_create()` instead
of being assigned only in case the CAN socket belong to the j1939 transport
protocol. This is needed to the correct filtering of the can diag module.

Patch 2 introduces a list per network namespace containing open CAN sockets.
The list is protected by a mutex.
CAN sockets are added in `can_create()` to the list and removed from it
in the `release()` calls defined for each transport protocol.

Patch 3 is the core patch that introduces the userspace structures to query
and receive netlink messages for CAN sockets and the actual CAN diag module.
The latter will use the userspace structures defined in <linux/can/diag.h>
to filter and retrieve open CAN sockets.

In the current implementation, every CAN sockets in the list is
returned to the userspace, however a filtering could be implemented:
Userspace could possibly request only bound CAN sockets or CAN sockets
belonging to a specific transport protocol (raw, iso-tp, j1939, bcm)
and so on.

---
Change w.r.t. RFC:
- header relocation, from linux/can_diag.h to linux/can/diag.h
  (Oliver Hartkopp)
- file renaming, from net/can/can-diag.c to net/can/diag.c
  (Oliver Hartkopp)
- guard renaming, from _UAPI__CAN_DIAG_H__ to _UAPI_CAN_DIAG_H_
  (Oliver Hartkopp)
- handled J1939 addressing in sockaddr_can
  (Oliver Hartkopp)

Signed-off-by: Filippo Storniolo <fstornio@redhat.com>

---
Davide Caratti (1):
      af_can: ensure sk_protocol is always set on socket creation

Filippo Storniolo (2):
      af_can: store socket pointers in struct netns_can
      can: add can diag interface

 MAINTAINERS                   |   1 +
 include/linux/can/core.h      |   9 +++
 include/net/netns/can.h       |   6 ++
 include/uapi/linux/can/diag.h |  55 +++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/af_can.c              |  38 +++++++++
 net/can/bcm.c                 |   2 +
 net/can/diag.c                | 184 ++++++++++++++++++++++++++++++++++++++++++
 net/can/isotp.c               |   2 +
 net/can/j1939/socket.c        |   3 +-
 net/can/raw.c                 |   2 +
 12 files changed, 314 insertions(+), 1 deletion(-)
---
base-commit: 0cf905cb9a12dbfb5d14896729b74508f83f73df
change-id: 20260529-feat-can-diag-d7acbf5e22c2

Best regards,
-- 
Filippo Storniolo <fstornio@redhat.com>


