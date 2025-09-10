Return-Path: <linux-can+bounces-4644-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABAB51B0F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F116A07EB0
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809C2192F5;
	Wed, 10 Sep 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjoOwVqN"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80823DEB6
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516304; cv=none; b=S5eVESVbvKtsAiaPEPa2wT79WphPb3wZ1ZD6OX+dD1Rw7jfekDqGVaSDNKUccv00AhXCE8sRVzPgL+37mh16J7cRRDTMsHs5o4IEuXPCL21h5FdCW2v5Tt8b1n1dHx8RSZyFEpqGrgSUfgkRaU7d+NJumLbZGi5W5aILTN3NZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516304; c=relaxed/simple;
	bh=uWh2OKcVz9DCFtrPsdYgcy5b7vywON1/DiUJcenSAgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=el2/keS13P+Hg4YjvBgVqgbghijIiXOpKSDlLYy4rKnX94fWf4/E6y/Goq9/KaUf9RI5Mqb8p60rTrQUy7qHOWeu1vElFltyKQ4XY24csTdPPkVa5rkF0jr6vxs3uGyWMFPiZiN9nvzLR+QXB/2jOBfYlmDKQ1O3s68ZGpCE4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjoOwVqN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757516300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NQQqBZHNxMocorkspmt0L8tFqjo9uqxEdKBx5pukg6M=;
	b=YjoOwVqNTrPaIoHsC70QN9U5gjPyeIo83Gw+LfXfSUPkp2liVLPVgmZAnPx63cKZkGxOab
	P/ID4H9AJl0zsgghbeOvPCPK+Vm20SZNab0LaNAe2TbSN4uLx0rBhBeVnwYi3/8uAEIb47
	qKlq3ZDCLRdLwvC5PODPZ99fd0Uen0E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-27EI38hhM_6z6uZIT-holw-1; Wed,
 10 Sep 2025 10:58:17 -0400
X-MC-Unique: 27EI38hhM_6z6uZIT-holw-1
X-Mimecast-MFC-AGG-ID: 27EI38hhM_6z6uZIT-holw_1757516295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B301956089;
	Wed, 10 Sep 2025 14:58:14 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 003651800446;
	Wed, 10 Sep 2025 14:58:11 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v4] selftests: can: enable CONFIG_CAN_VCAN as a module
Date: Wed, 10 Sep 2025 16:56:06 +0200
Message-ID: <fa4c0ea262ec529f25e5f5aa9269d84764c67321.1757516009.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A proper kernel configuration for running kselftest can be obtained with:

 $ yes | make kselftest-merge

Build of 'vcan' driver is currently missing, while the other required knobs
are already there because of net/link_netns.py [1]. Add a config file in
selftests/net/can to store the minimum set of kconfig needed for CAN
selftests.

[1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 tools/testing/selftests/net/can/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/config

diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
new file mode 100644
index 000000000000..188f79796670
--- /dev/null
+++ b/tools/testing/selftests/net/can/config
@@ -0,0 +1,3 @@
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VCAN=m
-- 
2.47.0


