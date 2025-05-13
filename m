Return-Path: <linux-can+bounces-3568-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98391AB581A
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8201888546
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151A482F2;
	Tue, 13 May 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="f+wkdzgO"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2091.outbound.protection.outlook.com [40.107.249.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81028DF0B;
	Tue, 13 May 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149015; cv=fail; b=femq57mWlDCPvPO1mlrFb0AeD63t9l96RWsfnyfudIQxw4hGRKNDWViN8DfGSaRaqiniGXZpOZBSdbY+yqt6Mi5FxAVNh9SDy1xnQrQVUjh4MGF5sWUTUpMWM9fh4KicsuZLnyfuj2ybNNVSpcOhbYHU0t2c4iNqN9NM/18pVoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149015; c=relaxed/simple;
	bh=350GNTa7aohS97IatXiEx/CFEthIfWZVEV6fztpz4GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOLUBz34hDi96uVkPjL3ruhMOlVRZSnTkXuwJ/NicjsvB1pKDlV7vepDQ+fKX+AyN5jbl/PjKTUWYRtzw6gGiuyH8ys5hTPOOlXAU9NXbnyeUcg1W/mnH0nGAmPczhbkECc5yweifZQpruQ2yVcSlTd+AiAAWepI4TRdbo3cPu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=f+wkdzgO; arc=fail smtp.client-ip=40.107.249.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyoNan2BFVV5vD+g+wY9UMz2Ih/v7JOvTbeWp7hiwOw/dUKtfi6EqLXdPYJg49oyWtm/2XErhXV4pZoXQF/idt/GLWYM/iu0zjtxEMIEMZ6CpJFcaD0lb++TDWuT1ydjpm72um56xeCrg6PLTTriX9oHaEqd/PRhOBeAFRPcM01fAUKeijNl8PuZOAVn/4e5UfG4ypgdOfaZ3TzsSIXEy2NRMr8eo6Pqpb/RQkoxKget3FtK+TOckDZhbJopDMJOD8Sgnt3BVea5rs+1idETTauskvJwtChnzlGw+TpFRdOerchbzFVVlz4/11jxPL0yUReOQKSkBP/54GJTLeVGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCLIuIZ/HO2lzM86bIvEEaduvhf0RGKd5VL0TlaUcsc=;
 b=vNoU6Ipr43g+0+KD5hCeQepE21iRk7LRBe7povPo1musp3QcnO5W9IMnmofWO+K7oYEdG/TiN+y412mm3dfVldk7e2QS5kTyUGD8SvohtubqY7YXRPpMUEZ3irKAQw7zG8vEBrMzTIJ5++HaOQPXR1Wb0x9uDU4te30oAeKHUCTirxsYSslKh1kQBI4+/opOUbPyiPelZ7RUXfPLDQRgRPfR7OhoiBZCmJI8gKPLk4AjeCrh31bGa+DlaWKpp1QQEhx9WesM9FGcRiEoMXbQZrtw6zX5e+bIQwXW1rBBj+OvvUQRiA/aEv6OqPwH1iWtuoKB7iNVxG5lLl4piIlLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCLIuIZ/HO2lzM86bIvEEaduvhf0RGKd5VL0TlaUcsc=;
 b=f+wkdzgO21l8ivYgb0DVzySGRcysOMTPCm44pE8BTgNg3hi9G4bXXPxtVuMG8/vn4hDdfEciG+MIaplOXaKV4PstaZBSDBMvrf2DnqouEds1MElw2WPZe9k5Mm3yzfwqo8jhDGa2SM7M/m6RRyxJOCq21hXbFR34+KwPZfnlD+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AM9P193MB1096.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:10:10 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:10:10 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 1/3] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Tue, 13 May 2025 17:09:37 +0200
Message-ID: <20250513150939.61319-2-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150939.61319-1-axfo@kvaser.com>
References: <20250513150939.61319-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AM9P193MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 588e24ec-4723-48a2-5afc-08dd923040e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hd2jBAJ4Rdz8iWzZ0RvmOEJQmOLh7FnYYOkm1zWRa7U5ir1B1p6Jv6QkperD?=
 =?us-ascii?Q?cVHBk2WDyDFfsWfcLpN/4j/POoOsujtllPKO03WD8CVdp97WhNYtX9bL44en?=
 =?us-ascii?Q?YPD/+Wngx6JjdXCawWcVfmUAVBV5KdgWzZKEyblabEQD21oT0sqZaNjP7S6y?=
 =?us-ascii?Q?4dWmB1Q9EoE9X0ORrO6T5l4V2JvPCBeiNL+8CJhrgN0Mc7aj5IuvKGI0VzP9?=
 =?us-ascii?Q?tvmPj1u3Iq7X8LnaJbMbv3WyI+Hn34bXdb+XW0cWxo9yBGob+AqUu4G7SrK7?=
 =?us-ascii?Q?lystqGVIFGCzanzx9HDxx+dXyi/T8xhPGKpdvo/n4beMQjUj4GlVMEKq+JKd?=
 =?us-ascii?Q?q7iKjrH/fzAoV9Ys8dmxqtUoxbomT5QO9oiaQKdFpWNnJVqb0/IZLkg4ZC4a?=
 =?us-ascii?Q?KIK0jZL96z2FimT8OMEv++J7/FoUP+xPHEkONuXcLdFZj+GIbIigEmM4dlLP?=
 =?us-ascii?Q?G/J1f5CU8/te0MNFnlxTTi2ou4Ata/bta7MO3XWRcZNKrKLEjDfJ9mz2g9p3?=
 =?us-ascii?Q?dFC9JOzwWAGr5E/ct+h6OVf1sPX87jtNSUY0DxALC2QmjXVykJp+FYlErgW5?=
 =?us-ascii?Q?+X1iFdJq4v84dbH5+g5r5YJJHlZM1zLzRLl6VbE8PjKotON2M4LE/uiHmGbR?=
 =?us-ascii?Q?uahy2RQQ0yy1oFaGUuHm8B25w23NqRjjWV3R9TKwn9ayOk5IQSMMG5ENb+2E?=
 =?us-ascii?Q?ayN6TYt5l5Kf6s5q7vyA01DT6v1aGzyFzMpzszB7K0SE3Vflxri+Cvfnjc+w?=
 =?us-ascii?Q?/RWtplDu7CbCK98OtMALWyLMx02hH2OOThqqLqhQV0B0P3ifhIkY6INDA9wD?=
 =?us-ascii?Q?AWaTQ6ahZJMM9HyPdqvFCg2UuY2e9TtT1IMeAd2jW4dgDtVMFeaLb+0ocR8W?=
 =?us-ascii?Q?tW79lTWSnoBmiuHqTLfKx6IqNJ9FBfXhr2Rl/ZzLbIrnA1s2oGrXtymUzc+R?=
 =?us-ascii?Q?hyov2A7C3dzYF2glVfBLUzX0aB6gyvjZjxWERPtTPIQRjBs2IAQg8Pte+7Fx?=
 =?us-ascii?Q?ChavjMU2VDyT2Wqz1w9Xdu2mYtyId6TQPZ1gjt6/pPJf62GxcOQar8AcaT3R?=
 =?us-ascii?Q?5YXawSUcTCcaIsnY4A8bVio66r0UYfpso+nuw4rHd544/GSKWq9oDthAziNk?=
 =?us-ascii?Q?GxYIP+RdhRK7c+CI46SblolXddZK8B28h/a7gTJ7YVSy291074SU35ljUZ5Z?=
 =?us-ascii?Q?pURpZ7qms17KTw/fOhZmxmm+pzH8VUkbqCE3U3MFFQGqJEhL/oKGp1WnWtsL?=
 =?us-ascii?Q?n5Z9RTxWDDWi6rfqaSXn5LiHICynSo0Zkchcd1GYdXg/Bee9LqwdxlLRDiHr?=
 =?us-ascii?Q?PYh/hMLf4mIojtd7w2VHtRGEq5QdiLkcq2kqhtgjzTWv2hMRR5ANdDsGka7/?=
 =?us-ascii?Q?RebvWYPYFsZjY56XWBerNbjsuRhNtEDnw4W4pf16ZN1lRpVrb93l5N9S1/kz?=
 =?us-ascii?Q?ny2psPT0OCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWQZYZJ0bINEzk1RELY2czhZ1MB1ZlQtYCUor60/2hTZymdhAL5qMT6xKTr3?=
 =?us-ascii?Q?CAkF0x1ACDXc6lFMbv0TlfBGJ+lgcdLo3OzmTr2OXQEoLcDVX+nA/ZX6+Nmu?=
 =?us-ascii?Q?Wv/JBt1V35FWiU2JkC5NOddhfnY87iU/waiXQ0rBg0zhHJ91IrgLvLRzmIjG?=
 =?us-ascii?Q?iuH0Yd2EzoMOEfTFr/vHWcejnPDhJ/n8c62NPiZpOIIPU2/3HidcWQ65iIEx?=
 =?us-ascii?Q?NJlOtFo6Qo8q74JbnfRVr+0S0x+26Jn5jP71F92R6hvThDR15s//ebL7hYAU?=
 =?us-ascii?Q?9COtLB5DWPFhgG3fJxFYny0Uo4ZgN6EYSfyip1obfXU8MhUMejIEkavlFuci?=
 =?us-ascii?Q?21iR2VVTSl1zQFjVoHDS31Zn1g+28L+z+bMxYD7iF1+X4igHExLq1ziYUEEe?=
 =?us-ascii?Q?ijVXAarj+NiOnpHcp43qMSFG4QVLTFstL38SvFfcwfMraio5j3fTO9Ni7a3g?=
 =?us-ascii?Q?CLo559A7IWazp6cif4ydHuc/YSlko5TulRO3Tw1wQz1RPctR9iogL1NWNTLs?=
 =?us-ascii?Q?jMnBsv8KSvveF2DhU55TeovNjiAqelOOcU8nHxGevovHmCRe7EdSzbDzXAwK?=
 =?us-ascii?Q?dxxyGTH/AhWFNeWHunpBmfqHP9EkfW07rnf0ArYAY5eZhRF67pN9xGw3K3PM?=
 =?us-ascii?Q?0u48drE2vQDwemVnUWrtIxy6aNQcql1SL58ngeYwLqmJTwsT2Qb5/kPwVaZu?=
 =?us-ascii?Q?2GUMVtRzhVV0bV14KK0qE5gX80rznx0GXFRgliUj25BcOG92XUwjlkwLf5Ho?=
 =?us-ascii?Q?Fs998rnEYxvHCDY4Yrfkzbz8I3iWS25vUyh9uJYFwBngUH5sOo3z3W0FbEKq?=
 =?us-ascii?Q?XzSfi2+3o+YQ8G3sv7XwClPKstUUi/lEpCRFesQ86odQtAc1xc7DV511Hhpa?=
 =?us-ascii?Q?duRCcI6l+V3bbl829PNZsHoPN4jxktEwhzyVOtj0UZohN35ery6PfSJTaDnl?=
 =?us-ascii?Q?LGbnsjsrQfd0dZD/7JlvWoVDqG5iJZp1meOutzgseoBm6W0IU1s1GGAbA/k8?=
 =?us-ascii?Q?x1zGDgTBBMLKtHa+JgfekK5uNhJDJLAnTzC/3h6itNLAeiHAp3EDJirTNsmo?=
 =?us-ascii?Q?AUg0Z7McMjaUsKMtkMMi2NuA3CaSUmTo8SeHE9Lnz8Hc8uQT0EGAMAX2wyzP?=
 =?us-ascii?Q?RWhB6SXpeaWII2VwXnXVFc5Kex9qokVT0U5/YRZt5AtgQa8uxlLh+i06N+43?=
 =?us-ascii?Q?1zyg1DbtiI1SSWqCXd0LZM6wqgONez0RU5qF98IY38Bjmn7D78UZ2JJgvheo?=
 =?us-ascii?Q?uiqg5ygKhYimU7UHK6LNlSuNcb9qKmR7l2gp8SNBG0bXFNJ4wsxgnEYwqq1t?=
 =?us-ascii?Q?KGiqMr35rwBkVgDVXMlkrYJLl0VtElFqzWPiPOmGUw/zw+e/aHDm31r1jZ+U?=
 =?us-ascii?Q?N8rq6wFfB+QcoPY2tO6c9BuUPfQPA6wkcQW4Bmn0pMzqXEtu4Rv++u7hcdU7?=
 =?us-ascii?Q?+n9HibFUMSXaPMR8UbJvUwJY3A3JSZ8lGMtLLCOx+hzNZWlmjsht9jyK/EnD?=
 =?us-ascii?Q?9eI6t8gmmnDOlLb06D5LuWMjs02E/xXanBnYJJc28HMhxwRwr5ra3mMAhK03?=
 =?us-ascii?Q?BSd+eTvqUQEkbnU3kUVJLhPk9nqL4C5EKQnPU6fQ?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e24ec-4723-48a2-5afc-08dd923040e8
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:10:10.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70n3+3IMkuhrsoWwYABASutAON3s6pka4cjIBfpzg0eA5c47tww2PeofYskuxC6f0kyGy1j9t60KFkFIlZ2wuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1096

Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
to enforce an edge even if a different IRQ is signalled before handled
IRQs are cleared.

Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 83 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa04a7ced02b..4d84f7d13c6f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1646,24 +1646,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		kvaser_pciefd_read_buffer(pcie, 0);
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+		kvaser_pciefd_read_buffer(pcie, 0);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0, srb_cmd_reg); /* Rearm buffer */
+	}
+
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1, srb_cmd_reg); /* Rearm buffer */
+	}
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1691,29 +1695,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
-	u32 srb_irq = 0;
-	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+
 	if (pci_irq & irq_mask->kcan_rx0)
-		srb_irq = kvaser_pciefd_receive_irq(pcie);
+		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
-
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
-
-	if (srb_release)
-		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	return IRQ_HANDLED;
 }
@@ -1733,13 +1730,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 	}
 }
 
+static void kvaser_pciefd_disable_irq_srcs(struct kvaser_pciefd *pcie)
+{
+	unsigned int i;
+
+	/* Masking PCI_IRQ is insufficient as running ISR will unmask it */
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
+	for (i = 0; i < pcie->nr_channels; ++i)
+		iowrite32(0, pcie->can[i]->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+}
+
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1805,8 +1811,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1820,8 +1825,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_pci_free_irq_vectors:
@@ -1844,35 +1848,26 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return ret;
 }
 
-static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-{
-	int i;
-
-	for (i = 0; i < pcie->nr_channels; i++) {
-		struct kvaser_pciefd_can *can = pcie->can[i];
-
-		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
-			kvaser_pciefd_pwm_stop(can);
-			free_candev(can->can.dev);
-		}
-	}
-}
-
 static void kvaser_pciefd_remove(struct pci_dev *pdev)
 {
 	struct kvaser_pciefd *pcie = pci_get_drvdata(pdev);
+	unsigned int i;
 
-	kvaser_pciefd_remove_all_ctrls(pcie);
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
 
-	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+		unregister_candev(can->can.dev);
+		del_timer(&can->bec_poll_timer);
+		kvaser_pciefd_pwm_stop(can);
+	}
 
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 	pci_free_irq_vectors(pcie->pci);
+
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.47.2


