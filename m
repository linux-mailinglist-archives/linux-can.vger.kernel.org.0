Return-Path: <linux-can+bounces-4420-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FCB3FE71
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2355E189256A
	for <lists+linux-can@lfdr.de>; Tue,  2 Sep 2025 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7F307AC6;
	Tue,  2 Sep 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir4peew7"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3BD307489
	for <linux-can@vger.kernel.org>; Tue,  2 Sep 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813556; cv=none; b=DkAlddUR7PQ3FSwUCWZMMLXoJiv3laQ69xyDPeHuu1oYNEFZeFYfg9dRxZNPFf4bW04eNjeZZ/28GJxbQvV+MT3d/6jbwXXBBFj1Tz5OrAzAon1Eta498A3l9p3ffpyUMfVpADwhD2a55mjcojEGHTMEt8DR3md7K0A69XEfGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813556; c=relaxed/simple;
	bh=7MbhQWnixouFVCj3yHweqkKae9POkCMa+fKcpUs+h10=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Du0SohRBrmCB7F8KLuBWDkhiL1aSFCXQYsQUNQVljCnYfkGm8Va4N82CH66XwXQM2najB21fcL2kToB8rnz05RiTNkmgHDfmbLZMjZqokTobp3bNSGtaycXbcqMaZeqQf9eKEvERQAuRUm1ZHeqY/KjuT5GfGGPaqbjOc5hK2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir4peew7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756813553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8H9e9OjlcFZkxcW1OgC10HiSjOdFL7X3T0kdatIs6Ls=;
	b=ir4peew7mUG58BrBqSCHrlR3XtZPFkhONTeGPVNS3i+t+nyMpkr0BZP0UWH1G+ckSt+E/o
	84P4d4XVynFmm7sMjmDU82/vIvuFwYux/irWChRkvHom2FNxveVYEYBiz4y5FSyf4OUAxw
	2qQxuTOK3rmM8FcxpLct8AtHZxpOpgM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-95RCqrtMMt60E9cevduyMw-1; Tue,
 02 Sep 2025 07:45:49 -0400
X-MC-Unique: 95RCqrtMMt60E9cevduyMw-1
X-Mimecast-MFC-AGG-ID: 95RCqrtMMt60E9cevduyMw_1756813549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8743C1956089;
	Tue,  2 Sep 2025 11:45:48 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.118])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 038BB1800294;
	Tue,  2 Sep 2025 11:45:45 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Subject: [PATCH v3] selftests: can: enable CONFIG_CAN_VCAN as a module
Date: Tue,  2 Sep 2025 13:45:34 +0200
Message-ID: <f1b942b5c85dda5de8ff243af158d8ba6432b59f.1756813350.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A proper kernel configuration for running kselftest can be obtained with:

 $ yes | make kselftest-merge

Build of 'vcan' driver is currently missing, while the other required knobs
are already there because of net/link_netns.py [1]. Add a config file in
selftests/net/can to store the minimum set of kconfig needed for CAN
selftests. While at it, move existing CAN-related knobs from selftests/net
to selftests/net/can.

[1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---

Notes:
    V3:
      - sort entries alphabetically (thanks Vincent Mailhol)

    V2:
      - move CAN-related knobs needed by [1] into selftests/net/can (thanks
        Vincent Mailhol); remove enabling of CAN_RAW and CAN_NETLINK since
        Kconfig already implies them

 tools/testing/selftests/net/can/config | 4 ++++
 tools/testing/selftests/net/config     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/config

diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
new file mode 100644
index 000000000000..3326cba75799
--- /dev/null
+++ b/tools/testing/selftests/net/can/config
@@ -0,0 +1,4 @@
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VCAN=m
+CONFIG_CAN_VXCAN=m
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index c24417d0047b..18bec89c77b9 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -120,9 +120,6 @@ CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IPVLAN=m
-CONFIG_CAN=m
-CONFIG_CAN_DEV=m
-CONFIG_CAN_VXCAN=m
 CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
-- 
2.47.0


