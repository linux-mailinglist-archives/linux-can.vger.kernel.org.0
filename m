Return-Path: <linux-can+bounces-4040-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A48B0ED4B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C5A961B4B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6827A44A;
	Wed, 23 Jul 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ZJwVTu1s"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8327E077
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259598; cv=fail; b=QgtQYE5dAvhkvIUDb9/brIiflm5vzSJAC26eaNMMqJ3Y2UHcc4UeTAw4sDyqTTHJL8GtH7oc2Jur387x8DbjptZl9Ct2PVfwCiWGP6OadSuA5zHJpOKHSyuHSe43RXjVTN698QXxvxhD8gR65a7+axWRem1j9ua8K/cGFvSuO3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259598; c=relaxed/simple;
	bh=G1UnLT0A3t6rAvBH/9/MhcK22WMWA4Y9n9XTkcIoCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jG4z/ANxGWdHDLknq7onZp1y295+Dz4pbCDBuAsHOGlOCD/gF/88dKL9T46hV+qNyqemQAzgWQFLAjJr9dgSrvGmHa9WnOJaA87rI8r/1muuLp2xcINSks+0iMReWDCXlrUsG72oFe+wMZZj+ciU+/aE8IzG7P7NmOJCvulnLMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ZJwVTu1s; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gym48K1xd7d5kfC+vbKAUN2mM0xrLt7Iep9s6etuW0OtxZUnC9EjnFC3wQg2bms/37gFRzYMmb1bnK3aoHJlv2n5fJYbnip6nhHJkqr8zPoiIic8cnvd0ksFDX/c/MP/nTMP7OE3fpK6x7qbTxzAYIyDCZjaKN1AJ+JgVcLRs2vULDHArZYW6m7Ee0mLdvXcJMbU2XRJ6zZbFuNy6kW0TWI5BjgSFmCHiweH6MHDwM3CHSHeI0pXe9TRaIrV1s6pggSiAByZy7MZgmLJMQGkF6a++oPfhDhBH1MZAUkKw/v9yX3K3lqp9/ADeEa2/czq/ciL0GIRLWYs8aDJ+ezdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPxbGFTsr6SYfEDrCDK/UTcFRBUoeKrS5KxJb1CSEbs=;
 b=dSC6RWUgecnvFtSXIlvdRLEyFwEhRyfJC/NOEV22Se7p+WRvhhFzXkItIK2exdauixtwYMm+9+dm1V8ap7XSxldLHRXWMGL+0WRaSsUTFAUUJU/S1wNq7wK3WaiDetRwit+Vm6IAKkB+so/sPumsUg1fw5HzXRZBHv/xmHTyLtvktPLpmbpbQm1MyHFcojVf6j9cTZg/o3MkK4JBCFUWs+IoYm0Fwr3OJnQriryDJQCpOjdlzhMyHSu0XcJbjc+qRYfX7WgPbsGmP8FoY4bU6UF50dsqL44NDV833mUfYKyvtGEbjMBwUxrbPVfyHDPCN0BkfvVdS3MGDvEMgOe0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPxbGFTsr6SYfEDrCDK/UTcFRBUoeKrS5KxJb1CSEbs=;
 b=ZJwVTu1snaYllquhaXOzDVAsyP1b1jzCetv3b00nO9cKdP3rE7mzAtGPoli+9TLuNzW+KSDB/3wA4/KRuFU807/O+XC/SUgnZ9kS5WespbO58xZ9ISJ5+C61MLUBKhR/0bWQo770eFks0m7ALtPGGg499nI6MFDqtftJUw4M/7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:09 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:09 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5/9] can: kvaser_pciefd: Store device channel index
Date: Wed, 23 Jul 2025 10:32:32 +0200
Message-ID: <20250723083236.9-6-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ae3d8b-4a45-4e37-4173-08ddc9c38d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYWhTdaEhOI/p9I1JldCr1c/Ab6cqaLry2TrmxOtMjrSgtKXJl97anh2CIR6?=
 =?us-ascii?Q?CCVNaS/sfBGQSkXbgbzgRLzt3OvxaBcENH6Wny6h1oV5yMmoRxjjaZVPdbMY?=
 =?us-ascii?Q?mFNLUMvf7+Gx4mEa9+mf2iv635qyQQfJx01Fy82sTaGKFGBUfW/sHj9oaa+U?=
 =?us-ascii?Q?aQzxeRqmSrPHr34KeeCbWHMCZ0r054fXO9NgLxMUlotvLNgB2uihbfc8+3/X?=
 =?us-ascii?Q?6EMUdXKYMWgjKbvP32PUm7Kd37O1qT3iIPH+gB1ZvzXCyXM5KemuHEfNcZQ2?=
 =?us-ascii?Q?YDAIcumf2dA2Nr3k4B1fNeFSsn9R/0kDJz8vovmxUMXx9/ZnNg4TWI63AwuL?=
 =?us-ascii?Q?gSMok/GnWPeVTEU+KwZuSiEV7VoOHp0QlhELK0xBN2vSCB2mi0EYxCiodBJI?=
 =?us-ascii?Q?PhPq31DYliZr1ifzAj/3ggfD303QeMTG1rqwb6rRGn5hPm3FpOQvFtYAvhOL?=
 =?us-ascii?Q?S/ju468d3q5EBAB6xIodBuf+TVyp5QsxRAf82ncZIsJ2YQaTbXWlQ0VwnkeP?=
 =?us-ascii?Q?M0qmlSqiCGfQjWM0fKz47t27eax+eA4G9I1F+7ziD9kQmYpY74gVDiLB62AP?=
 =?us-ascii?Q?u8qOeJSlMWKwkqMehzV0nS4otM69lSlQHeNaNmAfyT8YN1atP5zzu53cA674?=
 =?us-ascii?Q?vwCFtrfyxfpM4Sh7UhSuBXH9YqAbwh7si/9iwvOp49sQOMDjU26RZ74G3Khu?=
 =?us-ascii?Q?sn1v7cWPd1k4TpoTnQceIYc2YVgTPy+RS7izW74jTjw/THlVc0DMuX3bgDOK?=
 =?us-ascii?Q?PyIfZl1ztRzn0BtY6AlF1ke4Xy3IAxnHTL18K7qAe1tdxPDC21pgDe7nBAbQ?=
 =?us-ascii?Q?8sNnHe4V1jE+FJ30jLInDqBx/vVr6D7rB1gzZXjBbpInfS9tX/08Vihcuhgt?=
 =?us-ascii?Q?KFgayxoud/2ktltn97xENpnf0dBr6ptE6eMbV7NP622CdbYLaBzg+wDWQzAg?=
 =?us-ascii?Q?Gjs3PLNmKXvdJdPtmULwlKXDBdzIfmmYusxU92Y0M4jPlKLijgSJl87rZOgO?=
 =?us-ascii?Q?RlJ4sJm1AnRFaPC3VMbENS9yuDYK7aFKgcfXsgwldarRj/kceRKydQ4W1EPN?=
 =?us-ascii?Q?Vg2Zxo5M7tH0KCHzsj2BMnV5OqezL6nofZy1PwBDO58iYnD/K0xQt7yC42/b?=
 =?us-ascii?Q?TT7RewP5QEkGlARw/QuNSgH7FoC47I5HOwGRpPkSrAr4Jj1O+bI+p3+pzb2x?=
 =?us-ascii?Q?Ghi9RPe6TQGXGLV7x3SyT5g2sVC8Es65Cj1fa91HocNGHxT0nDHdlSlLyT0g?=
 =?us-ascii?Q?KYLIukcdfi1pfMTRo46jg66kw+a5O5oQspscZ+GZQyhFcqXC9zXGIDQ4Ra1r?=
 =?us-ascii?Q?nDH7v20eLVofsCthEqidMYjA/Awbu0AgU81QMSiAH7DIt8HjQ0W9WrM7F/Wh?=
 =?us-ascii?Q?csQ+4lV1FH2uaYOEJPzK9F9Qpo367Um43dwmXbuFxgaXbSoVxHEkx7qtPqPJ?=
 =?us-ascii?Q?f/6CcgKGl5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bb4/jBlDRsfEUO/xs2ZlmTSJuKGHOlwwbdCCLLBJ3cyOr0wttOCrN3QL2HKV?=
 =?us-ascii?Q?OW/tciIxQXlWOohlsU6cyePHNffk+9AKYaMv9st+Cyq5nCzqA57vHFgOW9bz?=
 =?us-ascii?Q?NYQuuxLMguLyG4/J33oHGS3WElNFJD8/ATJRpNCuXbvnRXpgJ/fZ++0HGBqS?=
 =?us-ascii?Q?lKEKvst8DlSkQ8tr/5PrniIUoBcxkDxziJ1jSYesmjGvrue8jzeP7J8bABdZ?=
 =?us-ascii?Q?HNDx4Wh+pFlaJQ//m0UK9FaAuZFqYTYCuGeEFcxnBdrorcGlD+/Gb+mFfxPb?=
 =?us-ascii?Q?t1d7DzWCxhmqILuw7uwPrIZ4DehQoKSfwtwslREJRJlaGo/Q5B4dx1ZL89vY?=
 =?us-ascii?Q?71dB8BPjA+syS82FWhT8xlyDeh/GqbTRNcdWjyW877a9BL9/+HJWw3dBVUA9?=
 =?us-ascii?Q?s5YuZ1mFqFK41zcia5RsmSrGRNxWu85l/X2MghB30mEC8UuhEqxn/NHo5vx5?=
 =?us-ascii?Q?urvFBLevuaJ7POPJjNK0rcCgOEU+RxsRttvFPNBSxNA1dXiq68JxN1Q2gBAp?=
 =?us-ascii?Q?fqWvZqOsS/BjnYFxJNIPGIb8v8rTX+L0xdWUYjCaxRCvj7SIg1WP2uemBqk/?=
 =?us-ascii?Q?U0F3gyB0f3Dv+fwuGZq5lJhV5bD11E+lejjTiywaRDZhWPnjHJHZBcFKmpsL?=
 =?us-ascii?Q?DJXc835HnKDN503jhBAkFpXHueKz7GeEFCyMNTkvIknv0qb11mYHvSdla2js?=
 =?us-ascii?Q?KXjJnuqiaB4elG/L3el0pAdCHiVXWaA0e9BEYW4GzAGk2n69prrSqZbHgzUV?=
 =?us-ascii?Q?W+OVfXA3dc8ioGtjb9PElGyuQb6/tM7L3NRY/oV4LuvEcoUM0Slnh8ViOAPK?=
 =?us-ascii?Q?gWjQPwesNU/0mjQihTkDaDM//dXJSnUPChGJohKQA81gs9YyMuviq+IPMfef?=
 =?us-ascii?Q?VskGC8ZiYEiqvBpFkf+RmiZnjiRtlQEFXOsoDWhlb8bqogZy2pfURr7H7qX6?=
 =?us-ascii?Q?cQ3G/LhMDtZIVE2ZCQbESLHQjxtnWp6/VqM5j5xgBfhN6V25hO7PC2+LHjs5?=
 =?us-ascii?Q?iWN39OIjeWEkGjq8EwpCHNCeKrHS4Fq9QmedaUehq1xQP3ahF6VqjbTosXDE?=
 =?us-ascii?Q?Lnuw2tU4mfKPReUSBa3slVAg7v84Z7k31Rw45b2gaHoILCC2dfLgSenZGklZ?=
 =?us-ascii?Q?ZKtTRMw92wfZ29mrA0wfL822sL0HrPd6vAPT6Y3H40g3nslzBjPW6gH4hDFE?=
 =?us-ascii?Q?RNak3WFQnTYPLF8OzmM1Q3+EDk32Wc3tBK6eQV5V8q0di/w4feo4cgRMBPXD?=
 =?us-ascii?Q?WHvfi4decZz/xl11gCBhO1EQXWgrC99Cw/Ql0VlN5c/aylw+E10jEQR9ICF2?=
 =?us-ascii?Q?7orqY96ZRfJhed8dMip+KjXPdx8k5rIaXDR1KrF+cjME8elfSnFoos9+eN1H?=
 =?us-ascii?Q?WgkT4MQ0e49vd0oVnpf5XFR166kv/TdffBdVJIp62SDLtXJLIYgsLG1HVEwG?=
 =?us-ascii?Q?Z3uHcn6G6pwYSqc/Q/HF50ET2bDjuya9gykaN4LY9OT7DKIaHF5IqJOLCtBg?=
 =?us-ascii?Q?VnDF5EekPW2PI/Q4SQ4abzFNJ2CVwb2XoiF0ohxDpT1ZgEzT7CbV+r0AQFql?=
 =?us-ascii?Q?YanKV2Xikm5XR67ooI/erqsW1EQW1WlecdSvMiczTG0tznQuDp+h8Q0h9sMm?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ae3d8b-4a45-4e37-4173-08ddc9c38d9c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:09.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86VFN/6TOKlpFQ4f7t/iBP1aPg6JYKSjhFR4IN0fYc6Mdtg8oPxcsDagddWWLRwJTLEWJq+BytpiR8idRKNbV01XC5Wb4x3hIh66hrTqirM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Store device channel index in netdev.dev_id.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index eba19819ca43..7feece6d1d41 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1030,6 +1030,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
+		can->can.dev->dev_id = i;
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
-- 
2.49.0


