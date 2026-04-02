Return-Path: <linux-can+bounces-7319-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP0qLSBLzmmjmgYAu9opvQ
	(envelope-from <linux-can+bounces-7319-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:55:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B5387F92
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62F4300EA9C
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9238D684;
	Thu,  2 Apr 2026 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP+2aOC6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="stRYu8e0"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1221318B96
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127292; cv=none; b=fl7qwxynoQKWjn3lpXOeD4K0dhckYmQRxfg5HqQrkh7ZssGRrjBsUHtxQ/8ECOwePaPa/fqNtQNlOJ9UPvv6ZYgy6dOvTz3ZT7lakQFJ+kAp9TMN88V8GATyalth8nIKwe0b5k0hsJzxvMmy73shOigcrCQL5gKZ+q1F2K5G/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127292; c=relaxed/simple;
	bh=EMoymE29uzTRM7osExH00i6+hRe2tZR+Xz4C6NGOKsk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MoVmA0Ba7DsPQ9aL7Jn7OQgpbsvOsLYBdD+N+C77zFLEdEoyafTfKodkjW5McHzCGqDsYbCPpANTCiEC9Ns323DAFPxyGuaYySSpr0EbbcCINI/iiR+m4DOqtb/R1lic5/nC9LxhrBfA0TGa+Njm4A4IPNs9zF0THBs0jP5GTGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eP+2aOC6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=stRYu8e0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775127289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79i0tCydG0vzfz5aWS2cmODhdes+0/5YNKJFBMoObEc=;
	b=eP+2aOC6rsy2IUlmmir+S8k61C7CVjIbht5EGsMZjJ+mU9PeXohRsOrc/s3tLpOOqZyUow
	aYXvNLS/EHS2GYJl5GaiVvvCA7GbvfYHWBXdtALZWZjUF5xvaQlxaPEENmO8qTsO0wyjsZ
	R5l1sDakBJ3J2uo4Fu6qpL4ESTSt82g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-FgVNCSepNuemz-NXjYHbkg-1; Thu, 02 Apr 2026 06:54:48 -0400
X-MC-Unique: FgVNCSepNuemz-NXjYHbkg-1
X-Mimecast-MFC-AGG-ID: FgVNCSepNuemz-NXjYHbkg_1775127288
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48886f1bbd4so5548225e9.1
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775127287; x=1775732087; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79i0tCydG0vzfz5aWS2cmODhdes+0/5YNKJFBMoObEc=;
        b=stRYu8e0WnGRJi7RH0ZSATAAlIeTEW6gJSNLylZoMVBuhK8OX96xXBHwwbLMXYASrf
         KyVRsXKlM0LM6c3ztzta9AI3r9heKZrOMeZRVDFYpuJJ66L/L3cUMeg9gRKWCRQXC2Lw
         uRdJBaOgZQpgskciUrVNGLU6IKw1xkQauD2f0zbCj3S+ayqqL31nY6IJqL8pe8KjM6jK
         LZ0vmdmLcN7ZInba+Klt4+FviMfBBJxOpRkmrgGQ6I4o1yXNZ1a0rvYChtcJnjTSXHF1
         XhsoyrVQBJr3Tsm7mn102bt+vKXUvbaz/QJqvBFmLvypP4aAYu2gUzyoxSL5ZL2an3H8
         vyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127287; x=1775732087;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79i0tCydG0vzfz5aWS2cmODhdes+0/5YNKJFBMoObEc=;
        b=cvYE7/IZPvB2YCvxYEY9L5NLz9jYdjX0oBitM0AjxQy7nHLhkHXyp5ZJSsNlrXMwDp
         6l6f2qtnSHgYTAsJ97L/UXhF2q8cIP/CWJI+Dp8Y3YYzE2OQqdU6Ra/kadS9y6GsAKux
         iOILTAiWNUt6UU/gNGlRExuuo7KAyZrfgk7+Sz09FyXIkDTVwLuJW511SXc1MLad0gsa
         uiKZ9Tpw+Ca2c3JuHnCVDaonUHTu2duICFQKdv9OnC0eQWrKTGN8S7RFXIB45LfWU+0R
         RNk1xsRVGu24wJ/iF4E8vgEAf2wrrHgB063mMKN6o7w3lUCbuO6msmQULxkI5u9TlM5I
         leCA==
X-Gm-Message-State: AOJu0Yzs1lZroWGRmR0rPIUEcEwlmSPWpY1LsmoA+jPbz8zIlVSMgFGg
	FSCIhrSTBKj219jec9t6/9f2/RRin+wNk5qdbskwQT5ikjt3EzD9ZhqoaZeriWcdfHZdcMffEI+
	8drRyx0PU1DzTi0cMI9tHIacmwA9ugUR6xBrYtxU0PSmIPUkGAUp2Jvu4FNHqkAnP8w7mjBn8
X-Gm-Gg: ATEYQzyeNaDPk1re4Dk0LWvA4YtkB0o7DZFlyZeG618kc5Eq0L4299AGk+ON/DZGbd/
	iRD3sYq46gukHE7wNEFfVzVFPm+tFib6YIh59ixIi4x8qgA+F4BeLxKdsjFYMthMR0PyGCQB/ss
	itUtXsnwYZpz8yDNlaV0ucalHANg86o1Um5uzgDTtkKRLyfNE7woyXNliJAZB9xUOjlOYwAy1AS
	E1GFqPfZ2BBg6SEIDgxd19wJLOh40mNhGSbqlM5ra4vQvZWoMBMtoQWmCz16k/pjuy6u2Bd6fA4
	zDNJ+dRJtgi/5wuyCpBcOARg4XENR9pgw/C87Zebi74d/D1zZ/PJz9qACYJrfJmESx/2EpXLtG1
	hIEqaWI/AOdhimXt3tzLf7RaLrPYhvL2zTn9J5k2DwG9PQ52ATXZ5fFLOjoSkfLdNSQwc7WqRzo
	eUcXnWs8C/U1QEALoXbg==
X-Received: by 2002:a05:600c:4744:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-48883599b38mr107608245e9.26.1775127287216;
        Thu, 02 Apr 2026 03:54:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-48883599b38mr107607815e9.26.1775127286676;
        Thu, 02 Apr 2026 03:54:46 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm234489435e9.0.2026.04.02.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:54:46 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH RFC can-next 0/3] Introduce diag support for CAN
Date: Thu, 02 Apr 2026 12:54:01 +0200
Message-Id: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlKzmkC/x2MywqAIBAAf0X23IJJL7oGfUDX6KC11l4sVCKI/
 j3rODAzNwTyTAFacYOnkwPvLkGeCZg37VZCXhKDkqqShczRko44a4cL6xWNbJQpbF0aVUNqDk+
 Wr/83wtB34jMdXRGm53kBzY9/Km0AAAA=
X-Change-ID: 20260401-feat-can-diag-b082b4f75b27
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Radu Rendec <rrendec@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-7319-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C0B5387F92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
The latter will use the userspace structures defined in <linux/can_diag.h>
to filter and retrieve open CAN sockets.

In the current implementation, every CAN sockets in the list is
returned to the userspace, however a filtering could be implemented:
Userspace could possibly request only bound CAN sockets or CAN sockets
belonging to a specific transport protocol (raw, iso-tp, j1939, bcm)
and so on.

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
 include/uapi/linux/can_diag.h |  43 ++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   2 +
 net/can/af_can.c              |  38 +++++++++++
 net/can/bcm.c                 |   2 +
 net/can/can-diag.c            | 153 ++++++++++++++++++++++++++++++++++++++++++
 net/can/isotp.c               |   2 +
 net/can/j1939/socket.c        |   3 +-
 net/can/raw.c                 |   2 +
 12 files changed, 270 insertions(+), 1 deletion(-)
---
base-commit: f1359c240191e686614847905fc861cbda480b47
change-id: 20260401-feat-can-diag-b082b4f75b27

Best regards,
-- 
Filippo Storniolo <fstornio@redhat.com>


