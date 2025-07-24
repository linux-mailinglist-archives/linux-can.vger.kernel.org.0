Return-Path: <linux-can+bounces-4104-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED00B10639
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7E8AE38EA
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB782BEC5E;
	Thu, 24 Jul 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="YRosoO1o"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550162BE7B2;
	Thu, 24 Jul 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349138; cv=fail; b=EIgLL0W22oWR0whZfjaa5jBAkdCRcbEm+PLbZl3TMYTvySE3tpQmRHxZHSJ6K85vF9fmJyelaXb7+C8OLFBs/LV74aQs8LATC3dTu3eTZQZWXV5Dy7m3ocXj2A3yxmgQLrmrehh37vATgRTtbMhA6bPEGYvpz3v6eISmYMsvMDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349138; c=relaxed/simple;
	bh=oGUvAvBG74SUpFYLTdRs9ZEtBm/l4Ac4j9u1jq5b5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6rPqLXpK6GQhaBDCdD31wiliKB8KAjp+0h0fIshL1JWA4Kkx8f+dxsyRMdtY9vZ+mfCucLvwbPzyCGKrmnzEojHBbCQkYFaIwRnDpHwFSUyXksdq7Iczc2VFD42gDP7qc1vM0T6eyIP/eUOJ8xDFrJcKhG07EgtLvofx+7PhPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=YRosoO1o; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBI1H0R8qdm+q3qD/09MJ/Tew+II4xZJwuZfpgHV/pRCz1rxEzntU5/sjtm1hBf8lP5oDasMi3m/45iPhaBxGHAIDyel9zzaW5vTvJw6oSzPKZSBD8qoNLwoJet3cptJ5TVfI9GV6ypo7L828I019g+Q7L2DsFm/xbKMD6S9dYi6O7A+f2Y7IIFwKfa2jKN4Ci4Ae9usETOUtKCtNxnZJH2Cfogcnp4zH1k4ipp7DbzZy56FGf5XuA0l2LZtl+UfBelAC9Luk6BMy1FVdNeoOgwiak3ywxFULoOLaZO63CH6Cvm/O4HjYUtguF1e+4X9ahFw7EM/c/7NHYcnxWbduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L02Oy05p7z7DAqiP6WKNYFrzrq/2G5LGVsGPPLOyC9M=;
 b=uQgKQn3Yn7ulP6psWpal+NI1usH9QUuCyPi/MXqZi3Jv7U8D7o57f4l6Gc0cl2db9gwdOgABWweqYp863QWFFceUdPHcTi5EvGJrygg7J73RkncKFr/Owlt57bC2ugP6f3ego3EK/GTGFw2K8OvLzQtvV1dyCVPuDqejmkrxUeHOodeMCfODN9nACQOPXYBUHXEvxc8h02GHSwujK3aobwJctk4jrkLomi4EP1vBtodAKGkT63BDfkrJ6mzaZmxE3F5klb1e9KNWVEcpURmc5mVWW6KDaLA2hW3cUZfDTF2uMaaAvDf1yT5m8EblevfIEi3QWwlp5h/q0zcmHf6EJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L02Oy05p7z7DAqiP6WKNYFrzrq/2G5LGVsGPPLOyC9M=;
 b=YRosoO1oQ/C8ppzoJ43jVWGzodn7HANNNddpEj9Sd7A1W1AaOpriWFztQYQ23fKtOH0Ti4fhw+tQUmfU7W3nvo3l5Irv69tDJ2G7ooOK+HprgY3K1+MTW5NS6hf5wYGm5Z9RvUDbPxVsakJiGwKTi1FZI9cANKKTZMB3wqUOJho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:25 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:25 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 05/11] can: kvaser_usb: Move comment regarding max_tx_urbs
Date: Thu, 24 Jul 2025 11:24:59 +0200
Message-ID: <20250724092505.8-6-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a028d86-d2b2-49f2-9322-08ddca940594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoyjKQNghqcKGTl/uXrFxRvOcs9kRNQcCRpZA2BFdEu54jxu9zf+fKY3qT6P?=
 =?us-ascii?Q?0ZGKV9A08C1q1M+RsK19Zq3A7ZsWQrGX9JHryeRDS46Dw0x2GBT9SvJpR0zH?=
 =?us-ascii?Q?U5uJv8KYBn6Byem6Ta/z0WnDqUbswaw59aR1HMLdzXd/Le9a7LwwZSd9CvV/?=
 =?us-ascii?Q?M3X8kVJwMonGbn1iFZm3NTfVaR8imML7JCCdTuC3RNrQ6NWd7/qIuwajwCZ9?=
 =?us-ascii?Q?c8KFc4tUuU7axMOE7mbw8EcSNhSWhLg5KFWs2dpDniHvBIknqJxiVkoidIYE?=
 =?us-ascii?Q?Ez93cD8BQBu/QZPfOUgC2LbjUreFGM/sCNRG2kiZKVdS41m3clhHbthALyn4?=
 =?us-ascii?Q?F1MnE2OiqGigBrIa0XVV622mAsQy43xnLojNuEmtMQ3J3kQuIIvOT4ZbxVWh?=
 =?us-ascii?Q?+5yuQc859X/v+Ne4DzQJQRNJaRpfl60DxR94NFOJ1SCEHUNAKHZKNnaiLdle?=
 =?us-ascii?Q?gk9KlNML0ABfzN46Ug1KPfJLMJ+ws5cQ9eCShiM7dbB0lvObzXDtmy2pPrKc?=
 =?us-ascii?Q?pEeHu2TqD4xrm0p4juK15UarByR6Vr/CeQFnXkibJUbhW/h/EPBIc+wb3CJF?=
 =?us-ascii?Q?Xv7WUyOws5XSo9ZqoyllDpy83pwEFopxj4/AnyOThZioKWhD+QSaCjqZ50qI?=
 =?us-ascii?Q?AtBi05D8rH79W4QWPi6beJTenALeHDVPlSLyNGimZ6G+28ChDjKeu0L/OxJX?=
 =?us-ascii?Q?Q4Cm/IVOUFV4q1PKos5YFZUbw5ABqaQZpwFUwyKHpZbp75EkviERm24TJVRj?=
 =?us-ascii?Q?PLKIlFWJUIUAf7XEGlozCvB7QmwMi5sOT16hMpdldxRahxbrXFygiETsgPXC?=
 =?us-ascii?Q?jQTLwRrDCyEleayQsv60rqTz685jFyaUQtXuk4yIGAePdHdQCZ3yRPmK0uDl?=
 =?us-ascii?Q?aZHL24ivTTikmrgD0deFfsXnhvDpZmGqTS4Arfp1KyOJ7jP8Tm7MuWQvlaxh?=
 =?us-ascii?Q?5xa2QlpKdDWQMeNlCdwzCE0tDXSedto9pmep4iTF6LYP3c+Rn0/lmTF/R3qE?=
 =?us-ascii?Q?CCbKygsyUN1lUnq4staA8C7ECTV63LTC+zpNLfPUSUQRUnNz3dtlsStWQzR7?=
 =?us-ascii?Q?wlQDvqIXjcWWeCX+vQfcbhnrgRpu9YwtZ7YrRSH36Oqx9hvsYjN7J+1bkLqf?=
 =?us-ascii?Q?Coj4n1l1GcCKs1+ACAZ8vUKb9/LRV9+F2/ETeV8G+xPPzM8uKg45iN8jGmBb?=
 =?us-ascii?Q?RrMQfkm4Jtwp0RkcXcwUKV8/l3SBRy9kgIZgvBshgy/qYM1f3EwuittJMD/Y?=
 =?us-ascii?Q?cT4gFp9CEobo+906VdBucSQAkf4HEdEVqQXl+ADhQzA5zZYTDumKp2gUpSlx?=
 =?us-ascii?Q?ARBArjmeYRwBnGDl6IzZd167imCKtXLCfVhoDtq29u7c/KxF/whTRJg5uN+Q?=
 =?us-ascii?Q?rz7hyf43EMYQSMCvS3VIPHURBOGjAw8oQqG/jvW+Geq1BHmiW04DLLn7eAQN?=
 =?us-ascii?Q?Y2P60macEKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXJSbIPKRFdsE1cU7RHsgCMpy3vuQUmljSqIPRMr1Wp+e0mlwOqlrr7yHkuV?=
 =?us-ascii?Q?KAdftwF1SeOKJ4kj+M9JlCcy4nlwby/ewVEkcj3dAoRaHOdlkD2LW8rBiCuE?=
 =?us-ascii?Q?ATnWY+QzFYH7DzxvY34fEDe1unJdWFXaZdDWY/c68HuNoqMLZ1r/sH+Mv15N?=
 =?us-ascii?Q?IBzFtorDMUD1rPwFLVACPVg3CHaphyw2Cux8Vbb2pCAbiG7zdsQ520WKPhbG?=
 =?us-ascii?Q?eo5xTPp6NZKnVnVIlh8+2IXp01/Hw/Vtho6MHjbqLdGidLD7W5tmiYpPRnTf?=
 =?us-ascii?Q?HIeBPELR0Gqpt6k2oHnc1HGRZUFNB625jZOfmC4Eg0fMxrTifNkzmFvKqTCN?=
 =?us-ascii?Q?Gdv0pkn9v95j7+gxj0jLs62O+W8lLN/Ld8aoUmkFxCTwmn85VLXBxXmrNPZs?=
 =?us-ascii?Q?VlvhGVWTs9mt4HPmzYrHV5gVIjFtjU3Rn0zlVEVNk7uglKJ+Boc/6w6cH6Ac?=
 =?us-ascii?Q?9mPN/twPQ/8zR2YhFfBTtuGf98P49RagH3h1oCoaZ8Bp0bPn1HbN5tOZhpwf?=
 =?us-ascii?Q?3FRgqAdJta/Honcc8JXeQGyqJ2TeQty0v77qpx6m4ZfRbUQwtV7sswnhgzVm?=
 =?us-ascii?Q?DLrx4q3iU5X/3TycoAQ28P5uqY4EWu2rjMN0QSgT8mQ3iHBpWij7XkHY8h2i?=
 =?us-ascii?Q?cU/4NTdb0cieK+3nVtFd1oW+F7U1jVSI2nICDJATUMfOc6aj717g09sdxogV?=
 =?us-ascii?Q?z24t/IWVGaaEBBiCBtLX7ECQIqV1cY6NmqaJYUbUPUjrFZ5GvWg2ssDAKQSo?=
 =?us-ascii?Q?6u84dl7bcu4OBueZXwW9u7j3mc/XamT/VIwSiu7567ViXJiHUuZArB2/LVHo?=
 =?us-ascii?Q?6k2BmHIjSopqQheyhFNn58VWs/ihI3vQ112w6hw01IRmphyJ2pEqM33vWlrX?=
 =?us-ascii?Q?P8xgNPcHBe6tkIGIJsQ4sWVfJSbGvqs7sD3mTH8OxsCmMx14aITjwmODI7JD?=
 =?us-ascii?Q?4TljJ6hAKz7Rc6f9ePtoYoNTgk97HHY8J5Yt7DBrHp2IBz88r4OdbfWyYzze?=
 =?us-ascii?Q?QVhnGqpKZHVF6PvQCArPV56QKHbdNUXPLAHjYcnrnHYI6jlBnowam42YT35x?=
 =?us-ascii?Q?ZsibjMNLNCMF4lonl5eAB7+EXcmaS8KhSBozbFjRFJR+7lrd9dFk56Ua6ugx?=
 =?us-ascii?Q?wGZTHYB9td5nsP0jqy+DMvtyqrXzztWmGnXc15GGRE8bHtr0+0GPikSF5oIS?=
 =?us-ascii?Q?yLi5vD3Lgeqs6EY4iwRJaX8s7klVMIwO6eTMx5ySUtebbmB7KbasdukuwDpz?=
 =?us-ascii?Q?NUY2R/sfiK90c7tmbid+1F/Ef4ux4xRtOzn9Cw86CUsLbVbRGbBOkRCJYR9P?=
 =?us-ascii?Q?Romu3E7LAxfmxhKfLqYha2t1XbiR+rFWim1NK1K3b/+0PmK19gwDU4MHC7L3?=
 =?us-ascii?Q?x/+hCQbcnMuXegQ17aE92zUMzqdkzFCdCaAD84yV8kQfRQZ0hDuWGrI5aZZu?=
 =?us-ascii?Q?E7DNKgxi+I84OOVzTo0V6/WzaeRCTU5x6IU0nSDllq3Q+1lDRBx4hhO4lDMr?=
 =?us-ascii?Q?Or6nuzPmUJROuGNeNDTZyWSGScNBpTwUWyxDAg+alahzouAe+XAolSQKWel1?=
 =?us-ascii?Q?oQ/RvB7yQ5cPc3NUIbBtBivcXlRsg2y2GCwTClteORvnxqWgYx3aAhD86r4b?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a028d86-d2b2-49f2-9322-08ddca940594
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:25.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw5IyJEzbDoNKiX+r5CMsljnd3pTh8i55zA2rxVA9bblx8t0Bq0R4Gr4gI7u0/cltepmaVWx5Hpbjyzkx9Fur/ckapzpU0batWnzovr0ELw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Move comment regarding max_tx_urbs, to where the struct member is declared.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 032dc1821f04..fba972e7220d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -101,12 +101,12 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 fw_version;
+	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
 	 * also used as a sentinel for marking free tx contexts.
 	 */
-	u32 fw_version;
-	unsigned int nchannels;
 	unsigned int max_tx_urbs;
 	struct kvaser_usb_dev_card_data card_data;
 
-- 
2.49.0


