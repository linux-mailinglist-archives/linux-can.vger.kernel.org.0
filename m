Return-Path: <linux-can+bounces-8359-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P0tUOnuoVGrWowMAu9opvQ
	(envelope-from <linux-can+bounces-8359-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F574904B
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SVBfyf61;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8359-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8359-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0959301F6B9
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599B3D522F;
	Mon, 13 Jul 2026 08:53:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E83D47A8;
	Mon, 13 Jul 2026 08:53:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932804; cv=fail; b=d98832vlDjnUX3OGb5r+AKxmtjRVAf5Y/dhVcTuzovV1G5uvmrlkqFs2wCw4QGYx0cJXoCeQv4s9xgU3eof4e5jydpzuODUXUAnJwIlzQXrZBQbV0KRoDQ82bCKsHvR2kTTXYrn5LU4CKgVLX1HXLPpSiUmjLfZcAdM4Dek01c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932804; c=relaxed/simple;
	bh=qhmfD2AxaOMuq+vy7TjZkkjjqyVbXAB2QMnIDx07L3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtAW74BWv1xzI8K4teBqROh5KCnPjamMi6BcnB+XjpK1ueQNdIRr8bdRV22L5hkGOnvv4Y7GrmjuEQBUlS27/4otIdL5WgP/Pnq/iCjjuTevfcsvLfC5xShd+Ke3JS+mcl25Ao66zYhb6XIb90so2bP9g8uED+4WUxZOCac9kRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SVBfyf61; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtuhXbb8OsQY3CLvgNMzT6g0AYxLiMC9Uw3dEVv9Wv0lYqiSHG+tJSoSGrL2Vf+as9YAnzfSOewGMDD7Pz8JStAixk/wMhG50TYjJwVDSELfOxfnhhV53P6RElyguVmd2z2Y9yYmV3B5Sawi2i1aTvCPo9Aos9nMDf5/tcuJpisfeSt8cmrc0TPaVyQVTTKWlmxjGv1+d9PFL4rBfgbwIehkwlDUeGmyEb+Mlo2AGf7avcQHP1Q4YI0SfkHd94qG71wsUDizP9OpRgEuEA0X2ddKSt6SUNynPEWLK9JTenn1HhyiecQh65hEF6k3FdaFaezW2QD/eaiRuQPs/n4HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr5ij74tYnvdvl7zgYATzrBfCWM7e2nHzLUYpxmRo00=;
 b=fPWztGCeUs+3fNFIGxdjIJPX1ABw7Q2S5B5I9PbbKuEgVIlqn97d1AVu9UNuCVv2XEBB3ko/7rn/t3VL/belqg+Es8jBoAA94ipQYfRDk95c8CGF7LTB4XWWcrzMuXs3BOPptWFxLOonmp45h3qq31yRoTzBDSMyPQuqVG1Pn3rgS0nhWKykvjigxjPUslTTKY8299MPYXBzyDMW9msZqZ73dcxwMAHK4LtWxRme4fRyAfvWKuLBSKS7hFxkZ46P3h0Q9v6iyidueP2mnWE6pcPvbAr8XeG8JhSpp3wGhGLG7HNSqXKPUaCRzFfOVRsngSOXwH/xeyqbWw431mPWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr5ij74tYnvdvl7zgYATzrBfCWM7e2nHzLUYpxmRo00=;
 b=SVBfyf61ZfHDTjJkMA9InmKYUy19gMWaMrNAovfBjD64Pb6dLGsbah3mvbz3YDzkEpKnKtuvWU3ENvzKT2edNoNUvuPyH6FzQgAHHRN6gwZ76ao7Ymt3W4vVodWtbcIM5BWOpC6hE3kdSWoiAGu5isd/Kk+Z89FKbF8RQpT5b/2RKEegisO0qqKc436m7P9VF78SopCSGA10SAgYJxixQyRA0bVgRuYzCKtZH5Ao1caTU8L+Av4MWNJIe/dndrASgckKDs4f2OQ95qh17PbM1uljI9dLxDsRv9l1buUimX7n5oCsDS4Iw0CBJZH5HaILSmNqYme04XvYZtGsZW5Cbw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:11 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:11 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Mon, 13 Jul 2026 10:53:01 +0200
Message-ID: <20260713085306.2643794-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9d8d86-e439-45af-2879-08dee0bc2abe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 x85YeBtCMgduK+DRGU2RZRwm9CCvnVowXNDka7i/LnWgl8YbkKNJ60kDoV5jp0YFE1oBlIDeMKOElCbIa26RClkiXs9XZLkDLNMuW73rwHBm10rpGTlxrT2Tnz/+fGJ0Mgqjyljr/jZesRdXsaLxbRvhgSjWJ6IcnIWcMVNVNTbBXHfVkn+bN9fgrwRjymZEUkEtWYLJlvNk9vAWeeIA+4j5xAK7C+eI+1l4OXRwKazLVkrEBnksW+MHMbzUsEWpRrJ4rFs0tS6HKobjzMgJQYaLfLSU5DcROUuU0TzDCeCBK+m6vnVCvoqzxxdpRDh55JpHWYVqXx9WupQ4zV1CFOB+pTKtnXZS66MxCBNhG7W6AjGMCBncmw/pLNRj/yUiKQd7L6/bLneyXoZqzJpEIQ17fpvoE6JyFUu7tYz+MonXaW/r5X9/sAQju7MGiYaIP/4RYV5o1Fhao85D83qhQjLCvFXvZ7FUQp9HkE1pL1bu2tTrg51BJT5rpbOd/X/UZdTnxbF+b9c/5sUkhiagHEuuChvNakJVr+QkW8rIcIfWZ0DiJ4o683IRRXtnjRzJj/kuud9w6ebfCTqSP0xtqrWe4sYNq2lAmmmf1gsZvQClDwkUQR72IJuWtBqcOzg6PewfocI6BS16ckNud+kLdz+zGLebku5htITw0SwzGOs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MFhBM2JkQTdoVXdnNTZlZUc5eG92d2QrUG1uVUs3MGR3bnlZRW1uOEJpY2VP?=
 =?utf-8?B?YUxZRXh4cVhoam5QRjZFRHVmVWhTNnl0bHhRVTkrdjNoWDMvVzhLbWJaaEE4?=
 =?utf-8?B?b0ZpWWxOVld1MjVxV0owYm9OSjBQNDAvRHdUMnRqWlNjV3NnbUEvOCsxWjhQ?=
 =?utf-8?B?d0NYNDJPdWVFa0dBOXJQaHh3WWI3d1NyY2xlSDE5clFjV1BHRGlDdjNjZXFo?=
 =?utf-8?B?eWx4NXB1VEd1amdWR1ZaTTR2NVIxcDNFUmR2Ym9hWndSSXV4QUlWUFVTaDND?=
 =?utf-8?B?dTE1SVI4N1JBeHNWSG9BbkdKOUdUZiszVkZTMkZkeDdVeHBKeS9JRmpuak0y?=
 =?utf-8?B?OWkrUEF4YklCSVZkUktFM05Kd2JlRzBEL2pvUzBRTWxxa3R0enFKT1RqamVP?=
 =?utf-8?B?SjR2MWg5dm8vVE0xL0hFcFpNcWVGNllXTFNpMnZVbEswVGRyK3RZK2d4N2VW?=
 =?utf-8?B?ZER2azRyRWdXT2M3ODdlc0NKQkNVcGlUUXR3MU1OSDlxOW9vb2IxdmFROGl1?=
 =?utf-8?B?QnVjL2JWWXc2dXY5VjFiWEVoVUYvTHlFZjNYaEVxOE0wSFNNcUFIWHN0QndC?=
 =?utf-8?B?bDQxY1FoaEFnelZzMjBjb0VmbUI2T3U5cHVtSmlOaTFTNCttRXJpZTNITHFS?=
 =?utf-8?B?ekxWMkdnSVd2TVpRaDVlQ0FmS2ZpenZRZHZvMWFyakFGOW5Yb05wOVRXSDk0?=
 =?utf-8?B?R1MxbGI5RDBWRXFTZmJhVm1IQkUxbVJub2t0VzFlWHU0SzhXSWU1LzRndWVi?=
 =?utf-8?B?WDVvRFMwY0g3Ujh1SHJaLzBkUStRNm01R2lWNW42M0tMOVl3WGlOM1JQMC92?=
 =?utf-8?B?RmtBaEZ1eDVUdll6S2FQaFpIcG11d2ErN0UrUmdGY3luQTlyazBXckppLzRu?=
 =?utf-8?B?TjVVZFoxUklSck5XVW5MQU9mTkNJbDQ0bXRKM2FTTFBQc1VkTi9ST01PZmI3?=
 =?utf-8?B?ajFwKzJBdXZaTC94c0lwbEtyenhFd3NNSEllcnJMbUhONG01QitxR0JRZ2wz?=
 =?utf-8?B?Q0hvNUc5eXNPblNudmRKTWtxQllRUTRHOTE4SFpnVmhKMmNPYVphdjFvc3Zr?=
 =?utf-8?B?UlpaaGlkUlVKaExTVm93TVBMT1ltY0lmeVFFL3dOT0FaelFkcUl4cTVIZ0Na?=
 =?utf-8?B?OGtMVmZRWFBrZmRwQlM1cVMwQnFuSThqbzNJVjJRUk91am5CVHlXaDh4eklG?=
 =?utf-8?B?MVgvczB1dFFad2xPNlhsMnlacHdPektNaGg0WHpLbDBhMWc0RENxay8yNCs3?=
 =?utf-8?B?RlMvQ1lqNjlBdEE1dXUrZDlsbk43d1QxNUdiNmR1VDFyNG5rbXR3MnlIeHpv?=
 =?utf-8?B?QU5wQXAzVXBtSVlDdTNxT0RuSUttSTdUUFFWTG9ySkdCZG9qRFJRQ0Q5VHY4?=
 =?utf-8?B?ZjI2N29OL0wxcnVqRllLMW5YdXZOa29RK0psKzNMTkhPRmd3dlhaRlQ4TWxh?=
 =?utf-8?B?VHkvR0N1WGRlbXpWaU9ydXRtVVByNUtNQ282NStCd3Y0L3NHSERaZkNaV2xO?=
 =?utf-8?B?Y0t6eHNtczl1VElFM0RjbG9PRHJaYlRxVmNsNDF4LzdTNE43bkJuczRObkZp?=
 =?utf-8?B?OStVeGxlQmdXUHJUdXRzTW1VcDNGU0FaWFh4cm5jL3RRcW8rOVI0cEowMHMx?=
 =?utf-8?B?TThIeWpCSUh2ZDFtSElPRFhyYTlaQ3BjYmRreUxyUEpOYTlkZVl0SENqUjZY?=
 =?utf-8?B?SE5IMDFBSUxKSFdlQkErRVE4elN2WHF0Q2JZU1IxeUROMEhUbVhSSnpSSWh0?=
 =?utf-8?B?MUZiQlRLbHIxNysrdXc5SUcrSXdGckZGR2ZKOXFjSWVwMjJma3pWVnNVQU5z?=
 =?utf-8?B?aENVWDBMSThxTU41Y1FUNG1GMHBrV0FNMnN6NCtLdDcySllBLzd1c2pBSStK?=
 =?utf-8?B?L1RGYkhYQUJEeDBqdTZuaEtrVXpqYTI5cHFCSFJ3SUR1QXJZeDBzMFhObDYv?=
 =?utf-8?B?MGVCOFhCTjRUamE0UEMwRnRuQ3ltQS9ZZm1EZFpTeitjOGZPRC9FNUhsbS9G?=
 =?utf-8?B?Mk9rNnl2RThjQW9jRnBSK25IekpRTzJjb1BoNXlKNktGTEpQZjJKS3BMR1dB?=
 =?utf-8?B?TkhMeE82cW5ydklnUHdUaFRzNy9mbkdzMFhYNzcwQkdvam5jTEJTR2FpMkRT?=
 =?utf-8?B?ZU1UaGhpdjVKeENVam9GR24vcnNSWTN5dUZyUmQ5RnFJdElLaFMxRGJMMGhS?=
 =?utf-8?B?Y09Ma2IwSmNJUnR6Tm1rZXI0T0ZwY1p4QnpZbWh4S3lJbndIVDJJV3IwNm9R?=
 =?utf-8?B?RHhWb0theUZqUnVuRmZYMlhWb1hDTGo3eWxBdU0vNlJWQi9VT3lpUnZSNitP?=
 =?utf-8?B?Z3duZDh2VUIxbnJlU3VaWFM5NkdJdHRaZjUxaXFXMWhxamJ1ZTJtdElZSEJJ?=
 =?utf-8?Q?+oyohNb2yGYwksc8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d8d86-e439-45af-2879-08dee0bc2abe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:11.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UazC6MBBaV5bnldbwii4o7oYxpGxvl685XlUO15slKaAn3HnCm4St+axWtX6QR1dkulmu5EE6DtdLU6w8Iad+Gwi9oGWQ3KDKnQwdqJiz8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8359-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE2F574904B

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f73ff442d530 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0


