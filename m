Return-Path: <linux-can+bounces-4252-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61858B2847C
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6AE166035
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004202E5D37;
	Fri, 15 Aug 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdFAzaDy"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FB2E5D01
	for <linux-can@vger.kernel.org>; Fri, 15 Aug 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276918; cv=none; b=uLfWiV/yysZUZkaj3Z+6+W5yfrGKVGhJCKTjBQiCQOttrtrpuxSbuIzUg+H17tyeQmLhN5ub0gWjCj3fJUsuLqREPSTinC6T5ZxnQSNRYYV3P6iq+ErKwcpe8eAF7yITOZHE2uLBJ6heN/1Ut2z4FRS3h0dVBgShtikB71iQs7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276918; c=relaxed/simple;
	bh=IRTu6Fehk23EAN483PGYE6zI8B9SxvPHNGIclQYfNME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=afZwlOCmOR0TU6zmepLXH0NjTd/+ZaHDzBeJp2/rVbIPXeqaZp150sEv7kAmV+ouwVvWSN2fCNT48g+SEDg8vdJqXAD2ZYb2ame4OYPhVvU3EtT44r5a6CLLjhxV22QA2QmLpaZe35h0apncHOhvXllIRLSdxrwqxjoHn2tp5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdFAzaDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755276915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yu44M8XwakGm1CbH+4vez/Q1dA0UxQ2dRiNMyneWOLg=;
	b=PdFAzaDyBtNMk6SnFb4KAeWuPBoDjwr4eK2twMSRDGHYyuuFdjZly2sS33W5hvJ5AssS0d
	6SWNJY+LfUdJSdN7RwjPJVp7Ft36XyPP4U32aSqCDx8E1VcJB50HdvWkjvxyrZ2WiEUWky
	gvLZfFJGwEbtma5zubO0wiRwyiApvV8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-xKxcZUXVMOyBfTlKwF9oaQ-1; Fri,
 15 Aug 2025 12:55:10 -0400
X-MC-Unique: xKxcZUXVMOyBfTlKwF9oaQ-1
X-Mimecast-MFC-AGG-ID: xKxcZUXVMOyBfTlKwF9oaQ_1755276909
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2913195F165;
	Fri, 15 Aug 2025 16:55:08 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.32.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EE9A18003FC;
	Fri, 15 Aug 2025 16:55:05 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH] selftests: can: enable CONFIG_CAN_VCAN as a module
Date: Fri, 15 Aug 2025 18:54:59 +0200
Message-ID: <fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

a proper kernel configuration for running kselftest can be obtained with:

 $ yes | make kselftest-merge

Build of 'vcan' driver is currently missing, while the other required knobs
are already there because of net/link_netns.py [1]. Add a config file in
selftests/net/can the store the minimum set of kconfig needed for CAN
selftests.

[1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 tools/testing/selftests/net/can/config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/config

diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
new file mode 100644
index 000000000000..11a02b0a0c6a
--- /dev/null
+++ b/tools/testing/selftests/net/can/config
@@ -0,0 +1,5 @@
+CONFIG_CAN=m
+CONFIG_CAN_RAW=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_NETLINK=y
+CONFIG_CAN_VCAN=m
-- 
2.47.0


