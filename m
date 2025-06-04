Return-Path: <linux-can+bounces-3774-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CFACE1EB
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F0E3A51D0
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1528DD0;
	Wed,  4 Jun 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKtFqM1V"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39E4C7C
	for <linux-can@vger.kernel.org>; Wed,  4 Jun 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053222; cv=none; b=G3fPJSTatcQ9esAsBMORDquelkas0Xa0nin3a6q762VCZyejg1lcj7axqP7fzDIVjS5ER8sOPlHGW4356haCmRylFFPMw4tCi/YXYasU3AAn/VWvqLP3w29HAIp6BoerwA2ZgrTfT8qV3aJBOMbUONX7R27MlEJV6ChUd6NAIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053222; c=relaxed/simple;
	bh=fKcX6GitlNF6WLxf5HVWFQQMsW+EJ2DISflRRXiMFes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4/a6lKZg0BGHUQWOjkW4KAClDcXJI27I88V1XsIqrk21xBT/P7cek/6rq2WqqqgZY9mvQh1YamjYJmQc3Q5MZAWjelCA7CgDEhgbwJQI1DNHYeuMCND9TS26rDLw4odENnwJiNTW+eg3T4IYjHtQH+P3G82OoW5ebwTg6ZukDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKtFqM1V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749053219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyBT5nTuzq+r39RMZ+3kjWhDDuFKHLuaf1S3bjXtGGI=;
	b=OKtFqM1VWqDk9DEkvrs84WYdwKdNK/++mhCVxq3/wj1oFgHFAFs3QRRh2U0KlDTsqb/ueM
	Jb1rqX7L+u43UDKmXSf5YZjU4C2JOfmwTtuVNLrm0HR+mrkrglQpPVLx/TiQsoc62ZdtfJ
	V2g4n1Hop2E8R6h+okScJc5Kn6JrV4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-vWrkeHhhMeuJ6yb4H9FK_g-1; Wed,
 04 Jun 2025 12:06:56 -0400
X-MC-Unique: vWrkeHhhMeuJ6yb4H9FK_g-1
X-Mimecast-MFC-AGG-ID: vWrkeHhhMeuJ6yb4H9FK_g_1749053215
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90C8018004A3;
	Wed,  4 Jun 2025 16:06:54 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D44FB30002C8;
	Wed,  4 Jun 2025 16:06:51 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: fstornio@redhat.com,
	fmaurer@redhat.com
Subject: [PATCH 0/2] can: add drop reasons in the receive path 
Date: Wed,  4 Jun 2025 18:06:03 +0200
Message-ID: <20250604160605.1005704-1-dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

drop reasons have been recently introduced to improve debuggability
of networking stack. This series introduces drop reasons in the RX path
of the CAN protocol stack.

Davide Caratti (2):
  can: add drop reasons in the receive path of AF_CAN
  can: add drop reasons in CAN protocols receive path

 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/can/af_can.c              |  6 +++---
 net/can/bcm.c                 |  5 +++--
 net/can/isotp.c               |  5 +++--
 net/can/j1939/socket.c        |  5 +++--
 net/can/raw.c                 |  5 +++--
 6 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.27.0


