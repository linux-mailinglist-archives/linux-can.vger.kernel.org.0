Return-Path: <linux-can+bounces-4413-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61239B3EBE3
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C433B4BFE
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA6156677;
	Mon,  1 Sep 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwSadp99"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FD13E02A
	for <linux-can@vger.kernel.org>; Mon,  1 Sep 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742856; cv=none; b=kiwCzaWGrgYr29KWosMQyhfcLg5cxmMnuWcUczLcsQz5fKYhyzI+DO+DeLZhmW10CnUiTkJXWZkZLz+JfwNv/actwgcAzB9dqB6yHQoQ1VWDi9I8p8QcIXjyTS94xMuK+uEPXaNm29lLV3ueqXHlykwjn2F1vVyw+Pxdc/V7ZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742856; c=relaxed/simple;
	bh=sFBSosYT+A1SiBP360Yt88lm5+8DmXtwbTCRAR9siUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CHqbtritQVU/ALvR5CqDhBR68Jl4d1xrDyyIWg6cUCenR4cZLpDEscz8KOqwInutnXFMwqtH/D458sgOmGdcFAuQMxe7wdFjETc22yKdXh0ucfJK/YlWw5bY7SpG1WK0oQnK6llPj0XHXWvyPMQ7H5a4wI+Xgleske7+Dnl2sYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwSadp99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756742853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZtjLfywhy5X3DydOu3T3NKZA2RhjF5jxdZ6SzJcWXXM=;
	b=fwSadp99vsFWJFOC3NK65as1DO7imRwjL5ZXx78ic58+72KxDno/9YcfhTROhxfN1A2XQX
	CwWlO0QGlONVWpeQQD7zOqPo+oGUq7wXTQ5meloj9CKqgrWVIzYriUcpp6LijkTyhdY4Q2
	RjwjkwKsQhjwjjYbyZ+zO4uD6eX18Qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-HHV4c3EjNJiF01CFpnOXDw-1; Mon,
 01 Sep 2025 12:07:30 -0400
X-MC-Unique: HHV4c3EjNJiF01CFpnOXDw-1
X-Mimecast-MFC-AGG-ID: HHV4c3EjNJiF01CFpnOXDw_1756742849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CD56195C27C;
	Mon,  1 Sep 2025 16:07:29 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A08219560AB;
	Mon,  1 Sep 2025 16:07:26 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2] selftests: can: enable CONFIG_CAN_VCAN as a module
Date: Mon,  1 Sep 2025 18:07:20 +0200
Message-ID: <3424bff9cf34d66633ef410ba506f005a94e310e.1756742645.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A proper kernel configuration for running kselftest can be obtained with:

 $ yes | make kselftest-merge

Build of 'vcan' driver is currently missing, while the other required knobs
are already there because of net/link_netns.py [1]. Add a config file in
selftests/net/can to store the minimum set of kconfig needed for CAN
selftests. While at it, move existing CAN-related knobs from selftests/net
to selftests/net/can.

[1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com

V2:
 - move CAN-related knobs needed by [1] into selftests/net/can (thanks
   Vincent Mailhol); remove enabling of CAN_RAW and CAN_NETLINK since
   Kconfig already implies them

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 tools/testing/selftests/net/can/config | 4 ++++
 tools/testing/selftests/net/config     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/config

diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
new file mode 100644
index 000000000000..0cb5598eb702
--- /dev/null
+++ b/tools/testing/selftests/net/can/config
@@ -0,0 +1,4 @@
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VXCAN=m
+CONFIG_CAN_VCAN=m
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


