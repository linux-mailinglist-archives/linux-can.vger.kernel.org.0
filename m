Return-Path: <linux-can+bounces-7225-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN+8AG1QwWnLSAQAu9opvQ
	(envelope-from <linux-can+bounces-7225-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:38:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E12F4E79
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4CE3080FA2
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5B3B38AA;
	Mon, 23 Mar 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cQxLAMhx"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EC3B38A0;
	Mon, 23 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274325; cv=fail; b=Sg8S08+Q9b5YkYtZT6ITRTDRjxQXGavDogmE7sCti3Xb6ggSbHBQYDtiv27xBjuxLMPDDTqQhW7XjOBSBsxXwplIw7GiPK5ba632lexv9jpXnjKTB27/29c4/bcLJsHWUgY/76YZe3gx1w9tWgh/sVqDW4D57J5wJuzjXEW/oeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274325; c=relaxed/simple;
	bh=QL32SQZ+2vYlkj8xi4rW4inf47dALDarMHBIzg9Trx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KW1f9kLQXBXoMRmmqz1OSzvQv4AytCB1EsCG04TVcyMWk6vxXmqWRRTvxpM5IaBhQ4GGDLnycrwpEaRzwvxHSdX78jFixLwOtz5KB89cKZMcZ8tRM7EurPpZAgSa390hLZTjwmQnVBgdZQD9iYkgSejBGCrCbHXe6MMP9e38SvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cQxLAMhx; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPoMMtoX1+1BBJAwX0mRXmzvs0NI3viuJTd7hGFmOMYi9qxgwBBOAXzE0FudxKs/hEHUr5XUsi+wA//IVY9wI2jAT1uZ0t6Jyaehlal2dCrgZ+7iDvhTTfTST8jXwDv1Lmor2GtL0y31TKnHVG46LspJwpq5b0T34CtxWfysvQMCp0vwdzde1MmWXctkeKpeb8j/BI8wEVEZjExo5gR7dfheimSHE3n1D1BA2OK0bTf/t4Jld0Cog1pdi/NaklFfiqmtWMBP1aJ2ZauWxqII+oH/8jc+ZvUK3KReAWp5HqWHK1vzLCFoLUvXqm8FZY6ERmMSotIb5tGV+N/6Yom2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgct8BDL+mEAHL/acG6jpl8PpD1A8Nhl/q6XiCq29jo=;
 b=R4nhVLONT7p8QslsfxXvKimLHP6lKci0d6LjJyrdYgM9IpSrGmM8tBWjdq56kDuonGceAuFrFUGrfXAxrrkIM4xn/3vbz9jhuofDdiGRbo/YFzJ0hTZYft7tmKjuYeeKCSo2c93GArFnsl0/r7rJHAgyshRFR9qfvk8ymgaWlyl7GBC30z5osT3rME1Pfzvhb2m2ctj4XrM/2bPUVURE57TwGroxJtQpLYJ68jijfAHjGm6VN8G6jey3R5J8pE2lEDUg8SAxuCeCwLpwaPBKdAdAM2dnYdDXQxaauvJk6m5asTTEAvwCRuzuulljbNFjpwxnS3fu84ydTZZxFgRzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgct8BDL+mEAHL/acG6jpl8PpD1A8Nhl/q6XiCq29jo=;
 b=cQxLAMhxp77J+OGkJlBBJuV5mNKzs7AOr01Sx41DngWCMu0HZoDyhjDoVjtJ/rHApBHnw5ghI9oqlCH9w0iYxiJIOLwGRWfZAob6Hz3i1Zscd9/UX9mW1TYh8XPvwHUIFma1w30zYKCOnaW2VpsBklqABPc6lKMP+STwCJ7aUjEav+IJ/S5apMVJwDWCOditCJRx69i5iIzMfm9pNI8n3u+jxBnzmJe1q1W1tjylTumKGz+32v1CtRcRS7SpIVqM+e7kIi2/4vIzGHyzWmtG82msmlgXLACEdL5QqGnA9vlniG8IJhlJsTLXdkhOLd1m6nMyL4Wq7jHhQ7JcRP8IkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:29 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:29 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v3 4/6] can: flexcan: add NXP S32N79 SoC support
Date: Mon, 23 Mar 2026 14:58:25 +0100
Message-ID: <20260323135827.2129371-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0060.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2abf75-5144-46c3-28e4-08de88e4422a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tOJR6/n2DJe0figL6ovxCg1tqop61+Hn0IXhdGmyERxbZh+JoiYChCtJ/ZfhZLelkFMc5EqSIP4MOmWDFjZjIIZuNQe4SicTguTBrewIoD3HgA9Kgh+/KrgaZMcda/6Qd+uVzv7vJPKDvh7QgBhzMdeDDL9XHL1VU8GZKCASSEOC8mf4qBVJJ1FGQHyzRH3XoQ0i+5rdohM+2Pf2H1MxVTaIPRo7x7B2DYTkZ+Z99V7Ch+6aO4J35OeW5WKe1IpEz3znY+5qEJPRZEFDeXqulB+j+vkWMQCYJkZZu3w7OrE5ROW2FskTrvIhRgkCrou49+QnJaSMVozmKNGwrWVQ9CwvMlEzP+XkF3ikus2Aby8JcrHmnpnKSmxW2BD7ucayaqOWTI40SgpixKdhC77r0iPTQAWf7NLHBHW4Y/dAN9KtRBQgNMgI/XFNpZyds963oYYQzbqvg/wxIwjHyOkVTdIN/+u8P6+Dgs8kxFWK120diI6O/JaEm9ePYMcYjZ+gJ6UMQK67hLbiGbuV7H6oVnktCkPTzrYLx0Gt9ANxtfIvxgUIMOn/Fa/qx1SgjGycKow6LPV/1ohwV+HVUiu/HqwtfBJSkzPx+7E3GkmRVTXs7OLwdmECsqVzTt3blzvN4CFw3y306Xn6q4xkU00RpVISsDA04aRZtyR75jJElsek9RAyiBpAxybKqT6FDi/iHEvn1oJgcKlxHmeKda8mAi/mXELY/st8x3Ot15/5i5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHo4WkRJdFRybmNVQ1ZvOEh1dUdDNnZSYVZLTFg5aTVaWDZ0R21VN3QwL3NV?=
 =?utf-8?B?NFlKekpPUjFKNVI0K085WUN2OUtTU0hMQlN0elFlbFh4cVl0WHRQL1VpSHFn?=
 =?utf-8?B?WlBFTmVHaGVQWkZUZWRQTlBhZWNrc3JKNVRldlJCdmxHRFc1TXVTYVNrdEcy?=
 =?utf-8?B?VlVWQmtES3ljZWZCSTBpM0xBRkh2aVVIMlYwSDA4OGE4M2Q5Nm1HVmVTWGFM?=
 =?utf-8?B?SFlwaUJQcmthekVjYkVIUXkyL0NVNmExVnNXVGFKenJGUkNJRDFSUTJZZG1Z?=
 =?utf-8?B?WHdwRUEwTHVjMmxBRXpKZyswaHJwbGhCWnkzMWJRditXTVkraVFHVWYwTkNM?=
 =?utf-8?B?MndnZjJNNEVGd2ZlekFnWWxGMnFOdStwS3R5TzlIQUVkMkUzait1RjVJb0Zz?=
 =?utf-8?B?SkYxNklxTzFFV0tkMVNmYzJTWkkrWHk1Zm5EMW03Zk8rV1VmQ002NG5Dakl0?=
 =?utf-8?B?R3U5dGhvdjFtc2YyemtqemJlSm1sZGpiM3pvdkx4dS9yaWVzeGhGRWlBVC9J?=
 =?utf-8?B?Y1o1SDk0VE1JczJQZ0wySWxFU3hXL3VFcWg4bjNZdjNQWTR0THNDeEY2MEE3?=
 =?utf-8?B?aDJ6dFUvN29MSC9TMXkvcnJrSm9CYmhGZEtXWFdDVnRYVzkza296SnpXNmVX?=
 =?utf-8?B?UThRS0lPdGJsajF6em5qZmYwME5FWitXSG5PU2hsT3R6RFFPMGcvcE96dkFm?=
 =?utf-8?B?ZTc4eDJpTVBHTjJibDMzMjdxUnRPcnZHTUI4M1ZNL2JkRnZtd3hIU29YZ3l3?=
 =?utf-8?B?K0FpcEdaVThzZFdsMmVoTHNHUm9iakx1TEhsNTNraEFLWG4rcThFbEorTHB0?=
 =?utf-8?B?WVo3Y2o1clUxN1NHUVZtZk01R1BFVzUySnVMU0tJSFc2eWo1YS9rWXJLd2NC?=
 =?utf-8?B?MndsTVVCeDYwSlRIamxKUXZvbkh6YXkxc0lFVEwxcXFsekFHVDBJYkdQZ1FB?=
 =?utf-8?B?UlpodjZzM0xLUFNEUGlzVExibytwV3lpVmtRM2hqKzI1ek4rSUVVeDZjcW1x?=
 =?utf-8?B?aUg3ZkFBK2hOdXBtR2hBbmFyNmRpZW1TT01sam5VYVRveS9YYjF0bHFxRWUv?=
 =?utf-8?B?bDc1b0JlUE9yV1l5cFROYXRraDVadk94d28yM2NzZEhaQjhWV3psZmI1b2tj?=
 =?utf-8?B?aXpaNjRaU0Q5ZVYxQkRyblRBbmU4a2VsaklBbTNSdWRDbXRFZUFJMWhaR3ht?=
 =?utf-8?B?SjRod1MzbUdraGNkWWVLelllR2RnSU12bmg1TzJocGROL1d5WG1WR2lmbjBm?=
 =?utf-8?B?SnkwWVV1Y0dsMms4bUVzUUR1VC9WMnZndGpYZ2RzMHlaVkFrbVJGSFY3MWs3?=
 =?utf-8?B?aFNmVG9rQmVDQXN5eCtSeVYzdkd5UC95N01JSm5ldUg5SkhKUEVXVk10eDd5?=
 =?utf-8?B?cHhJbWFOaFlBb3UrYzRaaFdIVUp6WXNzSjNDMGo4UlJwNmY4aTc5enRzb29B?=
 =?utf-8?B?Um9pOTU1Q2FsTElWZE9vamlXL0dHeU15VmQ5K1Z1L1VlQTE0TmwxSXkzd0s0?=
 =?utf-8?B?OTRzK0o2Z1RlUmZVUjNxbmQ1UXI5TDR2Tmx4VnFOWkorMFU3ajQxUm43aFBY?=
 =?utf-8?B?UVJvSTR1S0VUVHBza0VLa0lwVXYxNXVVQW1OVmJyVHRSUDk3OThZVy92WmJV?=
 =?utf-8?B?VTNNbThRWTZnR0NCSmw3TzRqeVlMc2pnSlI2TXVheTRnR2VjMFdpdHlmSlow?=
 =?utf-8?B?SThLcEFiVm0zUVlNL21hSHc0c0FoZndsSFlNS3pWQTkyT1BjT2dOampWaCtq?=
 =?utf-8?B?WjF6ZytpQ0V1aitGMzMyTlVuTWN0WEFFRDJTT2FZdmN5d3dER1I2T2VQWksz?=
 =?utf-8?B?M1p5OWc0Q0VoRTI4KzFyQWhwdExEQ0lOZHRyOTNkZW5lTk03TmltV0lDSkhK?=
 =?utf-8?B?TDhScEFTdjZETEdXOUhPRjhQQ3JOUnRndHFkV09kNHZJQ0REUGxBajV3M1FE?=
 =?utf-8?B?U1k2RGhFL0FUWldDamJZNHFUVGVHSFZzUnFucmtaQjFpUk41ZWRxM0ZoZ2lJ?=
 =?utf-8?B?SUxaWFd5Z0ZFSlNFOVgvWllaOXd2bXM3S2wxT09WclFybG1qREV3Y3M5aU5x?=
 =?utf-8?B?K1dHZ05hYktMTE9NcnJlZDF3SDNsakE5Y3RzSHVjV0ptKzJQd0hnVlRKQXE4?=
 =?utf-8?B?UDRwS2JMYURGcmtsdTZrWVZuREtGNHh2bGMwdWFnNjErK0d0b2xQdCtEME1n?=
 =?utf-8?B?NlExNE1mdWZuNEZ1S1ZOZENUMW5SOWF6NkZhQTcyU2NQeElMZTl1c3pCZmVq?=
 =?utf-8?B?RFA0SFJOZXZXQ3RkK0lNbDhtSkxCcE9sWWtnOTNXT1gxdDBHMW95YjZTeFNZ?=
 =?utf-8?B?THBsZ2NiOEdIdkp0ODFySmRNcUJ6QmkrU2psZEtpTFo4R3JzanlJbGVTdlo3?=
 =?utf-8?Q?r+vKi8GkJkwK6t2U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2abf75-5144-46c3-28e4-08de88e4422a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:27.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9s3H+vJHf84wavi8Ys7tPuUzzkrHWpsgxcGbXLgPqNKl2IfrnXkjTPzRoYUiwsPFt8xL9TQ15fzz8MnDHaVlr9Fs2ohEwaPVlBz0Cv33tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7225-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5F8E12F4E79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 51f60bbf25fa..3b7913fddc2c 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2191,6 +2200,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


