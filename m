Return-Path: <linux-can+bounces-3240-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74886A72A43
	for <lists+linux-can@lfdr.de>; Thu, 27 Mar 2025 07:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD121890860
	for <lists+linux-can@lfdr.de>; Thu, 27 Mar 2025 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122EB1C3BE6;
	Thu, 27 Mar 2025 06:43:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407E1B4223;
	Thu, 27 Mar 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057817; cv=none; b=Xg7oVMkh6OwMELO0ABMohgCPSHv20gJGxnZgH7au5sMnpdjbaZKkde1BCd4dvaMq+aMveQYc81XJCwhjB/KWW4PJZanhFXmGXseU+OMPzIwQCnyT0gOaoqAav67OYhWJBSh5mCQoGZ5+0kP17w4Z0IAQBf75KcCfbGg/jD3juUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057817; c=relaxed/simple;
	bh=f4b9jYPlNOcvvmoM1IsldN4W9AdyvTeOpguC+L375SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+3Q6lU5043qH8GsN0NtBejDKZzd1uQjtzeJvm6AX+bzJqvnwpOPnWqOlMpr/PcdMqaq13aiZDPGmY8V27Ka1EIpGMBGPQuBVW02BVlyzJ3WpF17uYspgj6m1xB20loAL3ADYnm3Dt2+0bWQ882jPFz/R2MUpfg1lQ62ykal+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R4xmtH029344;
	Thu, 27 Mar 2025 06:43:22 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68nkjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Mar 2025 06:43:22 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 26 Mar 2025 23:43:21 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 26 Mar 2025 23:43:19 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com>
CC: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mailhol.vincent@wanadoo.fr>,
        <mkl@pengutronix.de>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] can: ucan: the memory allocated to ctl_msg_buffer is one byte less
Date: Thu, 27 Mar 2025 14:43:18 +0800
Message-ID: <20250327064319.3001956-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67e46af0.050a0220.2f068f.000e.GAE@google.com>
References: <67e46af0.050a0220.2f068f.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bd_2SMv_7sAArr9UeUPQ6R24tB7yRjyZ
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e4f38a cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=wvkD4opxYNpvLhmYr9gA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bd_2SMv_7sAArr9UeUPQ6R24tB7yRjyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=842 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270042

When executing strscpy to copy data from ctl_msg_buffer->raw to firmware_str,
the length of the raw is sizeof(union ucan_ctl_payload) + 1, which is larger
than the one byte allocated to ctl_msg_buffer.

Fixes: 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
Reported-by: syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=79340d79a8ed013a2313
Tested-by: syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..97c6cfa2d011 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1399,7 +1399,7 @@ static int ucan_probe(struct usb_interface *intf,
 
 	/* Prepare Memory for control transfers */
 	ctl_msg_buffer = devm_kzalloc(&udev->dev,
-				      sizeof(union ucan_ctl_payload),
+				      sizeof(union ucan_ctl_payload) + 1,
 				      GFP_KERNEL);
 	if (!ctl_msg_buffer) {
 		dev_err(&udev->dev,
-- 
2.43.0


