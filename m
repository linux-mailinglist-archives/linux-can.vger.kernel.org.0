Return-Path: <linux-can+bounces-4398-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7175B3BDED
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51683B72D0
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95C3203A4;
	Fri, 29 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C3kY11J7"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A3265CC0;
	Fri, 29 Aug 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478105; cv=fail; b=JI+cp4jJJadPjvF/4V/vJCPvMZiOEVFd1Tp+pYJwYYS63qglqgIPVsCpXS1jQ+J/WxdvJ4xgdlpW+FtkrvsvNJRPhyFwOvVRkS8FIbSJg/nXarpv1YzOGeWWF07Lqq98+PEnSS51htwkF1zOAth4IZGDLQEs7Ko3CsEpYITeUM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478105; c=relaxed/simple;
	bh=xS8fxoPL1TmqvJfurV5JkeDB8DCTNcWp3kYiiibn+O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nCizkOua88FfGSS55Jbeu7E/VGEEure76GaqRk8lEugpKooFYi0OpWG15lG6OWgHB3aZ4sY2fkngRhR4Dwv4YH1598+WnVBEMfkbTQKZ/X5IT1OJ7UwquWD9B/QdBTOFC43he8DQvhG4As7cKYCjF9bATWtM6BDi+kmgeQ9iVZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C3kY11J7; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7Q/6hbxwxaziYCjD6CqpeULQ1D0rbH5J+lN6eZ+xPMITJ3o7y0lZ+6TItzHLYQpipzRnF3S6YVniYMyVO0QRxg5aycYAKzx+WA+QD8Ijj4RZBksXm8X0hEFwwWG2JgkqEsuoPebX/i87wg0+phxZ3NMeOMoKEDe+o/3hs7UPH+iD0nnKcW1XhHov2/jESB5v0fmBhx98uzKEliul0Y63ZoLgzmlN5WMqBF90PR3R9K9jgAnA87zG04SGmcVNWW0Q3v9gIujI9bSarBq9J+CBWMST8cne7wTyCMbTwgitC5GImlrAjCQgAU86BKqIVTRnidb7aaYnYGAr+tkTTyHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELIcHekwDbvUC3OMi3E9NKZTVKhjhh1jFOizwmo5LI0=;
 b=LuRSDoOcy4LftZ0HGuF9XCA1giQarY0mrQfaY7arplL9XfYakzSwbrTY+YCd8qQ/wil2Ab26v54zIWBp3Gnp377p7gUWgZfhQ0KZuXJzDBPM1mD+EIkrsn9bEUNRXK6XmQkosVYkDSZ3/+GUYN/pMM1TlwOVvnKoDbsK88Pp7HMpx57dbr+EhbVngrUPPSOJ9OkBFNPaWxhqJ68+aUBftaKUODqH8wZ0Jn69sJMsBIz+ld8J0lofpWV6TR2oufqBEdQfKztVKbObFngu36ua1mSnODGra94vDn476X05Z4xCaA9Teb2R7DID8F4Cj3IppiWdtcJJZk8NO59xlEkQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELIcHekwDbvUC3OMi3E9NKZTVKhjhh1jFOizwmo5LI0=;
 b=C3kY11J7VnZ1SDYy8ZutB9sY3rDOzlEkZUSNywaf7kHDzPhl2PO+m4DeTDk/gbZnsoznWI36Bvj7YwHPPoqZTxOJeqdkW1kHfyuZO9tA1y6Up3ZmsgYllAOoj5s3Bq8V7qia7zG63O3qzddOiWG5StyHvXGYYiHy2He1mZh8XZslDsy3FLwGn6KbtdlwZzOZkQVRifcDjB/mUlKd2VqV+AMaVehAX9C7BuyY97d33CN/eNSnQYockwp0y6lOZyIovXXm/mviSy6L4hlXs8+GM4UzgAVpfHafseHQ6A2pw34WCVYeCzdJGisPkTaEEs49biNhI7mRSGCIU62E4W+7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Fri, 29 Aug
 2025 14:34:57 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:34:57 +0000
Date: Fri, 29 Aug 2025 10:34:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] phy: phy-can-transceiver: Add dual channel
 support for TJA1048
Message-ID: <aLG6izjPDAfkk4D2@lizhi-Precision-Tower-5810>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
 <20250829-can-v3-3-3b2f34094f59@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-can-v3-3-3b2f34094f59@nxp.com>
X-ClientProxiedBy: AM0PR05CA0096.eurprd05.prod.outlook.com
 (2603:10a6:208:136::36) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f01ca8-e0d6-41ca-564f-08dde7093a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTjqycqc0e+ZAKRjX3nW5GMXHllVuhJQFPQuNDqtW1DWjPk3QJ5wA6A2wPp6?=
 =?us-ascii?Q?VDyaZkjHBWCpplZhNoyZFI2OZijMZ+0YU19lusYLbsXgFpWHqze3a8kGWamq?=
 =?us-ascii?Q?Y/mKv+vuPy1lNLRSHekXY7/s5lrGetOe8fNXK1BHiN4viY3Z4KRumr670unT?=
 =?us-ascii?Q?PDxsL/Cby+mfvIyK8JABXo9R+6r4GKMsarGvq0Ud0toCjeb6vyH3WjTJUT7a?=
 =?us-ascii?Q?2wl9g6S+39+iFUW3UXPReRlS0m1AXcVPJYfm4qHmnWkk+IsDDRaaN5iJnErx?=
 =?us-ascii?Q?5nY6K+ULAtSkcFkfWDdh1dXw5sgIbfdapH2uxCvg/Ln1gO9S4PyyNr/VmMGG?=
 =?us-ascii?Q?eaNt49dZ0YG6fwYj89yKiRv2xTTbRPKH4H78z1508MXWRZXi5f3gdNVZsLLZ?=
 =?us-ascii?Q?kKqlSOdFlfzHRAm8XMXMuWjaphzttKY8/2usUMs+MwDeja/0AYVlDUbEoVz2?=
 =?us-ascii?Q?9fNJagchTHvSSlH8vLoT3sOwNb6mHKSFB1cEzUDLBirnKN4IsJpBqxFjJfOt?=
 =?us-ascii?Q?GP+06DUwGHBHzl2hOd9k1FNrFhrR1jVCUdFteVI+iy19zXeT68N3L4uFhm4F?=
 =?us-ascii?Q?Oe9tVtqtG8eV1fyknuQjNwGKMKSck/U1ByZUnIuYt6r443ozkmL19vWjqp/y?=
 =?us-ascii?Q?g/O03upQJLTNLY+ZqMzoMaK/cNb3aVgNV/stSFMNpYTUWRvjCKo4peU4TvsF?=
 =?us-ascii?Q?GV4CAiTgxRjBqL7yRxmCd7qeVajAMmqhUL4KXrI9VyUaCyHQuAXUKOCttLRW?=
 =?us-ascii?Q?owoBz5jdcd4tc80ZTh27NRpzIIB0PIburtAt7R0UyatjZG5JhxIEdGbDP4eE?=
 =?us-ascii?Q?LwhzCKapk1CmULgiRkGs88xjMUI44kesQAgBX+9yLDNraYSqPUjlB7tSvyzO?=
 =?us-ascii?Q?YZXpMmEbueVJKTRD53PlUE3joeUTV6yVA/iDyTyMV3twGdH3rkECOBVwFW55?=
 =?us-ascii?Q?O7/1aGfwXB4cNF9MppSIvO6vjQZ5kaskXtV5p0yRq7fTvyaaK9rNnvhgXwgv?=
 =?us-ascii?Q?NSAuI/F0qP9QjSNYokRzxp31RtO+6F4Q6ghoFwQz3jPjLA57wbZRMyxlJ49y?=
 =?us-ascii?Q?nSn2tvjPqsAc+XvHEeAyXKF6wtRTP/TSieJOAOxH0Nzsdmy23FcRQ64qBqAC?=
 =?us-ascii?Q?wOQlKOI04rjTDQXji+CvO4lOMg9BLXScV+WEOceeuWZQKsCnrLfhlRsE/AQ8?=
 =?us-ascii?Q?7oSOuNxI2969hdGBH1YIr3J3UBGPzMPeCDODgL5CxRFcAHsQNHbExnBIIG0m?=
 =?us-ascii?Q?0xe2AhlXh3Wxy3w87XislnOuz4E57XgDJdjvajmuGYGMGeOtX9RRk2OY/2fV?=
 =?us-ascii?Q?F2v1wIKyxqVlHuQOafyA/5aUyZfnjVVbnr9TtGlFX1C+xzFX+FhayU0lcFie?=
 =?us-ascii?Q?J/yA0Kwl2NWxIelKZ3LL+94k6BmD4JYFvxlndF7VjV2tPBB1ekXtgwifEOWG?=
 =?us-ascii?Q?yEzbYB5kUrdTRHc77jT/d/m24VAXVzPqaFAhydc1AFUQ9XM8799HpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9bCWT4SY0qVtQvLzpGjGZ/0lZAPkHr8P3bAECwW/o5LlbCQg4yNnJB5vdDv?=
 =?us-ascii?Q?j3Q1R/ZwmVIHd7lSNH4mYqmQ65Cj7fgJFUVnqywP1ySRZA2qkkOCKzFPwob+?=
 =?us-ascii?Q?kdH0GKEQUvZMnZGuH65qLaJEY/sVkxc6GMlFn8ty1RboxJ5zgByyRhllESqP?=
 =?us-ascii?Q?+XEGq3X+hkdFbaj8io9yG2qThnlt3KTUjKKtzKuJV4JwfiTLTRwPQpT2y+AF?=
 =?us-ascii?Q?wAcKAJ9HC0NUrRoDCx4VKtbSEIDMQUBAI39Aj12Yzx0JJpfIFHgms5ThPaiE?=
 =?us-ascii?Q?YLWHeRnlDTyQzmcdtHz38X/OCOHpGB39Cj1OHJyd0sfR5aazWxeE9OE9rFH7?=
 =?us-ascii?Q?xPAnFqJ1asB52lLUcOUeVGMNoEK+msSicpZ3pLneGNxmsWnRydefndrOt4j1?=
 =?us-ascii?Q?nof2Vlyco7pG0AlPlqaYWVpNEipJ+xpHqnIR0kVm0nMPH8/N4AHV6mB5Ioh0?=
 =?us-ascii?Q?LDWiQNdMtQjCjyY86LQF0MclNj0/ZhswLH1DSvp6C/dlqNv8PVAsDN8Y12tN?=
 =?us-ascii?Q?yyKXQeMBiuFQghUllaZ1wDi2gFZ3pzIYonqV9n4Vh9WlgyZbViKYbUYlsoxW?=
 =?us-ascii?Q?fzctS4ctGY32q5HjYW4KgKsHTGO8t9VTZQdjBMqLaxKVXG9gCURw5h8JIUrN?=
 =?us-ascii?Q?+KEAuYcGcq6pm5nxZIHY9KS+lzNjkl7c4BBC3+/XOLcsFGji7NFe0lrdSGIh?=
 =?us-ascii?Q?fieJaYZss3UdyX1ALFkD58TlTRaqxcPWsNcXRZXElOyBoMsMardOvgtuBnRF?=
 =?us-ascii?Q?lTrYQ0r2BqeLL2MbdURrRi4ngn5gKBBP1pqWtZ4dwWP46OaBc8ektW1PaiqL?=
 =?us-ascii?Q?z0LtLxDkhs14nZZT6nZJy1IBx3x4QD0kYfowUQUhjHK2s2VPXSN1w3e4vpAH?=
 =?us-ascii?Q?4NxdOVaSm3thmkvODazdbswZN2f6A7kYLn/eA0pGXRJUCJnBaQgiN5ticv5r?=
 =?us-ascii?Q?fI44J3a8j7hkba4nnkF9K1kiPDqYw6hqd06L2S1rkLkfAhADU704vMfV09U2?=
 =?us-ascii?Q?cVW5XMc7Lrm7tS4EwkZcPv1jpHXmXokR0cGSZYGNlMa7wqq52UBDo/47/2V+?=
 =?us-ascii?Q?+jLDArHBawJAgnZa4aA0UN3Qd+BhjNIq1orzvyRJx3EnCks1P/exJzdBBun1?=
 =?us-ascii?Q?i39raib7Zmj8YruFnG5vqWU+nIqscRhWyAGZSOdSQdSN8txMHUyiBK+zoZCz?=
 =?us-ascii?Q?OOKv2z/7XVCPBII4J5+Baa8Ic6keDEb2Xn7ufZoxwi4DBin4h4eMB8VgfXj6?=
 =?us-ascii?Q?Fmp3ViWN2H/VLA2E/PLBEYUFo8zf8YZgXj4QBeLYh8MspJODZtxMzHsduKYD?=
 =?us-ascii?Q?n59rvGveGqkDzId7kpKpF5Ub50OZGCiqVPHoYTPPVT6tZN/QmdPosFHFI5Gf?=
 =?us-ascii?Q?SjmvPhJ1V3ncQxvZK+AAMIzqbrnOlMrlVHKikDA2c2PtHeVbC6JNEmMp9eQC?=
 =?us-ascii?Q?TO3f2P+3v4bGMH95nqTaoVd95K04lWQRkYe42Q6wHPXdIHRNWGLv2w0CzQ+m?=
 =?us-ascii?Q?wSJMcZ1JDU7a/BEwH29qIe0nxEdONlp2xIplN/IHdsiazyAmFPRj3UTC3Qru?=
 =?us-ascii?Q?rEBG1dyj1Xwf329++HH//zN9amedkJ3iMlarTdlO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f01ca8-e0d6-41ca-564f-08dde7093a41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:34:57.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ulRFC3d2CNzzaR4dCGa2V8AmIrOq9EOOmGtxnBfyNlxB3ZeVzwcaRuSodx3GfVGa/MxQlWMPH0bDZdvx4IxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

On Fri, Aug 29, 2025 at 03:08:58PM +0800, Peng Fan wrote:
> - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
>   channels.
> - Alloc a phy for each channel
> - Support TJA1048 which is a dual high-speed CAN transceiver with sleep
>   mode supported.
> - Add can_transceiver_phy_xlate for parsing phy
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892c3346f45397ab54 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -17,6 +17,7 @@ struct can_transceiver_data {
>  	u32 flags;
>  #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
> +#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
>  };
>
>  struct can_transceiver_phy {
> @@ -29,6 +30,7 @@ struct can_transceiver_phy {
>  struct can_transceiver_priv {
>  	struct can_transceiver_phy *can_transceiver_phy;
>  	struct mux_state *mux_state;
> +	int num_ch;
>  };
>
>  /* Power on function */
> @@ -81,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
>  	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
>  };
>
> +static const struct can_transceiver_data tja1048_drvdata = {
> +	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
> +};
> +
>  static const struct of_device_id can_transceiver_phy_ids[] = {
>  	{
>  		.compatible = "ti,tcan1042",
> @@ -90,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
>  		.compatible = "ti,tcan1043",
>  		.data = &tcan1043_drvdata
>  	},
> +	{
> +		.compatible = "nxp,tja1048",
> +		.data = &tja1048_drvdata
> +	},
>  	{
>  		.compatible = "nxp,tjr1443",
>  		.data = &tcan1043_drvdata
> @@ -108,6 +118,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
>  	return devm_mux_state_get(dev, mux_name);
>  }
>
> +static struct phy *can_transceiver_phy_xlate(struct device *dev,
> +					     const struct of_phandle_args *args)
> +{
> +	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
> +	u32 idx;
> +
> +	if (priv->num_ch == 1)
> +		return priv->can_transceiver_phy[0].generic_phy;
> +
> +	if (args->args_count != 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	idx = args->args[0];
> +	if (idx >= priv->num_ch)
> +		return ERR_PTR(-EINVAL);
> +
> +	return priv->can_transceiver_phy[idx].generic_phy;
> +}
> +
>  static int can_transceiver_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
> @@ -120,7 +149,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	struct gpio_desc *enable_gpio;
>  	struct mux_state *mux_state;
>  	u32 max_bitrate = 0;
> -	int err;
> +	int num_ch = 1;
> +	int err, i;
>
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
> @@ -131,7 +161,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, priv);
>
> -	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
> +	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
> +		num_ch = 2;
> +
> +	priv->num_ch = num_ch;
> +	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
>  						 GFP_KERNEL);
>  	if (!priv->can_transceiver_phy)
>  		return -ENOMEM;
> @@ -142,38 +176,43 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>
>  	priv->mux_state = mux_state;
>
> -	phy = devm_phy_create(dev, dev->of_node,
> -			      &can_transceiver_phy_ops);
> -	if (IS_ERR(phy)) {
> -		dev_err(dev, "failed to create can transceiver phy\n");
> -		return PTR_ERR(phy);
> -	}
> -
>  	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
>  	if ((err != -EINVAL) && !max_bitrate)
>  		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
> -	phy->attrs.max_link_rate = max_bitrate;
>
> -	priv->can_transceiver_phy->generic_phy = phy;
> -	priv->can_transceiver_phy->priv = priv;
> +	for (i = 0; i < num_ch; i++) {
> +		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to create can transceiver phy\n");
> +			return PTR_ERR(phy);
> +		}
>
> -	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> -		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
> -		if (IS_ERR(standby_gpio))
> -			return PTR_ERR(standby_gpio);
> -		priv->can_transceiver_phy->standby_gpio = standby_gpio;
> -	}
> +		phy->attrs.max_link_rate = max_bitrate;
>
> -	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> -		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> -		if (IS_ERR(enable_gpio))
> -			return PTR_ERR(enable_gpio);
> -		priv->can_transceiver_phy->enable_gpio = enable_gpio;
> -	}
> +		priv->can_transceiver_phy[i].generic_phy = phy;
> +		priv->can_transceiver_phy[i].priv = priv;
>
> -	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
> +		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> +			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
> +								     GPIOD_OUT_HIGH);
> +			if (IS_ERR(standby_gpio))
> +				return PTR_ERR(standby_gpio);
> +			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
> +		}
> +
> +		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> +			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
> +								    GPIOD_OUT_LOW);
> +			if (IS_ERR(enable_gpio))
> +				return PTR_ERR(enable_gpio);
> +			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
> +		}
> +
> +		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
> +				&priv->can_transceiver_phy[i]);
> +	}
>
> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
>
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> --
> 2.37.1
>

