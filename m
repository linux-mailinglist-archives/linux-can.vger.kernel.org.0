Return-Path: <linux-can+bounces-3657-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F1AC0778
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C56117AF59
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EC28A1C0;
	Thu, 22 May 2025 08:41:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CE281360
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903309; cv=none; b=XOukpLlhRVhPPQGVa9vsAc1Il+s5AYhSgJT3PwBxBs5MgaIoJacqCCzhfRLjbiuHEEGv8kycqWeD9V3ebQ03/2XG7pe/X/H+Imew7O0tNVvXDBkRPLD+yv3TweyyRjdSLfuHsIDX3iUeG5hx24Xi02BTQ46ns3eWpr+DxuXe2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903309; c=relaxed/simple;
	bh=f6B/Gs2R/h2VZ58PvWhNWRf+c9KyccQuW+lJ1UcjNlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZeB7S7oMuuyOsIFjBTXqUWaLEhbqUn6VFm1dj4VnqUjZKrwgmVb/YlXf5z1mEDCCcOvA98O5CqODQs2u9g/zQBaFAFidUwA8WjH4akGslTXVpIwQonvzM2WnuTDQJTMc2BWCV5kj0Wd8zQYCjaZlsW+LQ+KdGb6zrIJarH8ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Um-0006IX-JN
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uj-000hr6-1J
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:41 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1D635417372
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 93AD741734E;
	Thu, 22 May 2025 08:41:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id abba9649;
	Thu, 22 May 2025 08:41:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/22] selftests: can: test_raw_filter.sh: add support of physical interfaces
Date: Thu, 22 May 2025 10:36:50 +0200
Message-ID: <20250522084128.501049-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Allow the user to specify a physical interface through the $CANIF
environment variable. Add a $BITRATE environment variable set with a
default value of 500000.

If $CANIF is omitted or if it starts with vcan (e.g. vcan1), the test
will use the virtual can interface type. Otherwise, it will assume
that the provided interface is a physical can interface.

For example:

  CANIF=can1 BITRATE=1000000 ./test_raw_filter.sh

will run set the can1 interface with a bitrate of one million and run
the tests on it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 tools/testing/selftests/net/can/test_raw_filter.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
index 2216134b431b..276d6c06ac95 100755
--- a/tools/testing/selftests/net/can/test_raw_filter.sh
+++ b/tools/testing/selftests/net/can/test_raw_filter.sh
@@ -9,17 +9,25 @@ net_dir=$(dirname $0)/..
 source $net_dir/lib.sh
 
 export CANIF=${CANIF:-"vcan0"}
+BITRATE=${BITRATE:-500000}
 
 setup()
 {
-	ip link add name $CANIF type vcan || exit $ksft_skip
+	if [[ $CANIF == vcan* ]]; then
+		ip link add name $CANIF type vcan || exit $ksft_skip
+	else
+		ip link set dev $CANIF type can bitrate $BITRATE || exit $ksft_skip
+	fi
 	ip link set dev $CANIF up
 	pwd
 }
 
 cleanup()
 {
-	ip link delete $CANIF
+	ip link set dev $CANIF down
+	if [[ $CANIF == vcan* ]]; then
+		ip link delete $CANIF
+	fi
 }
 
 test_raw_filter()
-- 
2.47.2



