Return-Path: <linux-can+bounces-7740-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 64TiBc/UH2p7qgAAu9opvQ
	(envelope-from <linux-can+bounces-7740-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:16:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE29635151
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:16:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HlePR4QM;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7740-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7740-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FA6C306756B
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4C3905E4;
	Wed,  3 Jun 2026 07:13:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86973F8712;
	Wed,  3 Jun 2026 07:13:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470838; cv=fail; b=hJHGHPbLmFU7zeZ9pY8KeXc1roL18PYY45jDjOKnFQWPcTOopJOYfB/NXty6IDqzIbf2xdXHXLGm/L25V5iKCNBjNBL//72hN1gqdkFw+kBTitqMEPQ8rekc9AT6DSvknNQ+iMBrQfv9/bUPyazfNwquVOGj4a3qso3JcsropN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470838; c=relaxed/simple;
	bh=X73y5eKmEDXMZkOeid41Y9oWjpHvGp3eMNcJyEOVYYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNnyRtPw4HFjZX5IwOqPZwGnnsRfgOxxj2F7WslBRQl7QgF2tWyINY0cbTQk+bPA2C7y6JGwb86lnv1R1TxqZujNZoMFKbhNUYLGd9pJRQXjVtWS25a2lXMK4CQfxtVsNK08G5YABm2FQf6AFuhqqRvt7ttZeYvj7EbLcJUYYhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HlePR4QM; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ93M7RAmybdafhvdOpW5IhtpJIhaUSB77Gp7Jp2KzjMzAha6WuFJyBLQtrlznmdMBbzMUQ35HkcmYkoDUmk7G1NiakrCWWzN4kifXOx4c21qG9bsvLc9HkKW3HOxTbRmiz59YpHMY64J/FCUe5/JcokFdh0iL91W3TlO2VycNApmpIx+fqYuivtgMuTVfjlyDtl6EyLM/9kVZxHvg5epj89YItuY4lvBXzRDY0r3lwjovvlq1+Jbohhm0FJtv7mzomIfmEb6zov5jva8CLKECFj4jv1vzwpKsupe45OMv7cWUgqqWlEUN8VFxzvwq+eoGmBejIepyDGir16wtBDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=Xy1tHwq3BbZUoJLBPh+EglHPG7alk3Ao5zrULDMxbXqK+aLCUr2F0IcMIOlYXeoif7BBmS7BWUxjkjQquBdEB2ofjWJKiUBnnqapesyKyoewB7pQt0/vDmGL/RzVaHAr6wg40UDPMaso0b1f9URACfH2CM5fsp092RCYlpRvNM1DHs+/oAIFnuGPQhYee0UyIRJlMb75AWgi9L+GtwjK7+6aHJW7nIb3d3KvRxwiFN0jkl0GSYw3+U8UKMn3w+DPN5ikM//5w+BeAj1LL7SSU8sh0pmpzWXRad/4jN8BXgfDmKXyF9hXlEIvnKUb3vl7PQO9GbrZJ5MC30lxJkBRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=HlePR4QM9ISsq8yfdatgpgW9d1pjk0rx9sqB5ohYy6YcEkcQsHuFlY1tKvVNOH1IIdTGUy+bR18SvZQHXqiDA7qGzdNakEcyGe2stwX+vNlknoEEU94QzlG7Y/lMR2ZmDdvbu+f/P2/V+Vl/UFFh5z2/eFswg+1gLrIN3YLKYhkcytuDu01/vgd6svYcZUeVReXGozrGemRzAbl6kAynMdU+9cTrROonv4i8X3Q7BzuDLVCodC2J2D7mz5WrHRQK1iufokxzZjAT+YIHMgTDc79jMYmIyGfFEGu/Mlkr+F+EEXQb61ubJIwYDKPzCNXrSirhDryZ04UlCMCbOTW6rQ==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:52 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:52 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH RESEND v4 3/8] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Wed,  3 Jun 2026 09:13:37 +0200
Message-ID: <20260603071342.641874-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac1b481-d3e1-4484-88a4-08dec13faa3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 wuLxjElZz0Ogry2ErvH20hEImWs6FjxZnELTP5z6TwBgv/SFr9n9nPoACXD8rkVRtHvCnRQU38EegOCOVKD20L70ded7bR2Zhf4VvUKK2N+S5ASJCMy6X+x9ZuB2RBjliLt4a6WvX/zMPJiiYr973QQwR/ctkeWPJkcQziM35I/gK7RTvle9xoVCB5eFSwnYfgl1VsyBfCtvSefPL/k2nb5xnWk9FNP128GwTlwyISI21tTnrLRjLEsVE1oMatP+e6m2sG08l5QYUbRYpu9KZ3RA9s22mNZVPSqSsApBit5iycEeIuL2hqL5CPJOb1ze4sVi77o/u+b9YXd374DEj4ufxRL8SFbWi/Li+sy43sJMkflSos2MkmDy9Y9UnBkx0FDXlo/Q6hhdEYvuDySJXNH1J7cATce8bJ5KNVJHSzjlpMGmrkuuwm9nr2fS9VSDrVnrdCoMEt/AND5wvhLNH8BcuFruJnP6kkxKbqPW9/LwzMLY4YToc9I9ZMdr2+dbSGg3zY/Pq6dojBfFL5zK0d5QBK4/TFPoTUNVTJ25BbekRAnXaoXLfJFByZAPI2zwpH63B+qJfDqRhZDq5cXd4l5hgMKkkGQTkwJ4no86s/xfAQMFYrHh4vto3c/b0xBE+wac0bzAMZnoAudc96Vh+SFk6cgm+A+Jg7953UBqNAY/tUWxLcySIYy4bEBbnWV/
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VVdIR2VDYVNKY0FHS1VTaTR6eUxRUFNzbHlUWlRjcGNadFNES3BSUnVQYTNy?=
 =?utf-8?B?aTV5aHFNbUNYTm1oUmRndzkwZ1Jud0c2VDk2OVQ5aEJpK3FTMjZtT080SzZX?=
 =?utf-8?B?NXViZTIwckU5dzhrc09YeTRoU3E0ZEQxWXlJTmF2N1FpRUZqaHNWNlBGSlMv?=
 =?utf-8?B?WmRwM2Rxc05adlRyTDAzazdtVXNKekszWjVQVHNUNGR0QU1pRUJ4aUdpVTUz?=
 =?utf-8?B?ZFFlb1AwVXo1M1o5dzRmTzZkR25MMFdEajE3dzJ2M1VaSTdFdGlxWHhYTU5m?=
 =?utf-8?B?K093Y1NJRFlTdVJkZUhSNytiSDBzU1dNQXVNZUdVazJSVkRCMnpTbUFZaldw?=
 =?utf-8?B?dmgrMDNtNHBjb3NhV1kxdUI1d2Y1ZU0zRDRvVWM0bmRTdVI0dVRoNi9UdzE3?=
 =?utf-8?B?K2tSQjhObW5JWU00V3BWWnl6UFBDb0RNRFR5elRzUUNJWkNFVXphdzJhdWZ5?=
 =?utf-8?B?NUFYR2k5SnVBV1lWc24xK1pjZExmN29heURhOXprdjNaTlV0S0xXb2EyUVg5?=
 =?utf-8?B?N3BVbnQwL1M3SVlnWjBrTUkrdlBZb0t4bHFPMDJzUUdGMGcxRG9qU2N4K3NY?=
 =?utf-8?B?QkJJWUpEbHNLUmRRZ2I2QXBOK1UvZUJudG9RQzVFbEdJQ0o1VUhmTlFPVVJ1?=
 =?utf-8?B?bDRlOU5pSVhzeTltYnB0YUgvOWViZnl1NlY2MDUwZjV5R0tXMXZMSTFsblBN?=
 =?utf-8?B?QTBSZmErWkVNNTZNYjQ4QjUrcGRqeU83L3VsQTFVSXBMUE9IeUhTVUtRVkhs?=
 =?utf-8?B?QjNGRkVKNUJNQUlSVWR3OU1PR1dVRnpldm0zVWRQZUpEWmxhLzFTcE9OQzRa?=
 =?utf-8?B?dkpKbVQybVg1WDJKVVg0L21mVWEzZk1kT0xiUitqeGI3WWZDMm5KQ0lCTWp0?=
 =?utf-8?B?STNwUlJKd3NLYklLSmcrY0crUzdYQWhDRGZGdGlPKyt6alRKL2dzZ2JJZDd4?=
 =?utf-8?B?Zmt6TjJnRnVyUk81ZXIrZVF3Zkh0WVVuWm1CanFnUkRuWG1sS3JkTi9qbkd4?=
 =?utf-8?B?bkQ1T1dnQXhDYS9oQ2pqQ3JxNnFVazZxSW84OHRGU2YzeGROOXBvUnVyNFBJ?=
 =?utf-8?B?dFNJWVdNcm9Zb2t3YURQUUQzQUdNaDF4cWhmVjUweGhJZ1Z1TzRJZkRjNk45?=
 =?utf-8?B?WjBsc0Y2dXlzM2Z6dXJOb0orUUpvWmVUUDhQSDZIZURaM3laS2ZlcXErZU1w?=
 =?utf-8?B?bXpiZTVhQi9iNUlWYjdYUTJjVjBGV1k4U25XdFlRQUgvRTROd2dLeDhPZmZ3?=
 =?utf-8?B?d0E5MnYveXgwYklvTm0xOWpkcFBCS2tUUlUzdVQwY1RZU1lDREtIQjFydngr?=
 =?utf-8?B?UmZlWjNSbEFVTXdUV3ptWjRBbVlBeHN5SmRFL2pHSzhrUEpxRkJmY2o1azAv?=
 =?utf-8?B?V3RaQS9XbU52Mk0wVEd4MkVSN3Q1QllHd05EeHQzQjN6T0JEWHpBTXhBZEhI?=
 =?utf-8?B?T2x0b1RIM016NXJ6c0lJdWJwblBTUHRXMVlNQ25tMmJTeUFIaUZEZkxhMHpG?=
 =?utf-8?B?aTMrTXF0K2dzbXVjRk40ZUlWYmwrRjRsMTY5cUFGSTEwNmlqSzJDZjEyVVlM?=
 =?utf-8?B?VUd4ODcwRGZGUmJXeTFDVlhFVHZCSldCc2VQWi9hWk1UUXk0SGU4VElBSWY1?=
 =?utf-8?B?d1dqS0t5UDluVWFMK1hBQTBXcDh0TEdqamwyUksrWFU0WGxDNVBIWVR4U2Ev?=
 =?utf-8?B?VC9jbmVMZ0REajhtQ1QrRlNYeWhkSDFCejcxSng1TWpuNlU0RFJtOUdnT1NM?=
 =?utf-8?B?eTgvcnNWbmVVbkQxYzZJdCtBN2dtQnVHanU2V011Z25FOXhLR1gvQnRXYUgz?=
 =?utf-8?B?VVhDanRkTzRLczJVNUtqY0Urc1BiNmJNdWg2RThaYTdYcFM5em5MLzlsejFz?=
 =?utf-8?B?eTJhenZlbFBuYzU0NXc3bTgwekt1b3UzOFhnZlA0S0JiZG5qOE5LRjExNFkz?=
 =?utf-8?B?eFUxclNwRFUyQTlqSmVtaGR2UHk5bDd2WkUzYkUrWmZEN0xBRnlqVnVmSndG?=
 =?utf-8?B?cFl1ZG9Sa1pCWUluTURweXovdGNxSDRFMGJ1V3MxM2dSSWhHT091RStHVU8y?=
 =?utf-8?B?ZDBqQ01RNUlld2diWFFCNnNzc3I0MDZsN2pJVXBBT1hObDJzaERiTjlKUUVW?=
 =?utf-8?B?b000UlBwendxUmJmYmRQL1A0WHZkaEg0bmRLT0FYMUcwZ0xoeDlDZHBpVFFp?=
 =?utf-8?B?UEZEQlZYM3BzUWdYM29YWDJRTldSc2dYd21PWHZyRERoRlhEMHFzZXY0NjZk?=
 =?utf-8?B?anhtV0EwSWpUN3pCTGR0WHA0aUoySmNybnNWdVJmTHVkK28zLzYrMFF3TmI4?=
 =?utf-8?B?S2p1UFl2a1FGMTdnKzRhQTVNU3JqRUVuUWxyTVdpSkpvODNOTUt1VFp0NW1n?=
 =?utf-8?Q?BxCGc35/XpGrfKoI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1b481-d3e1-4484-88a4-08dec13faa3b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:52.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvZ1iYf32ELQnxMi6anKHQoFrVzfYt3avr8bp/Zqp9zKcSCzFWBv00IhRud+P4wxQG/COeQrwMc1toCoGYkm9M3n6Fpi6LAYy5yjiZza4jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7740-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECE29635151

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-127), both handlers currently process the full rx_mask/tx_mask
range,

Introduce struct flexcan_mb_irq to hold per-IRQ-line rx and tx masks.

In flexcan_irq_mb(), the irq argument selects the correct mask set: the
primary MB IRQ uses mb_irq[0] and the secondary uses mb_irq[1].

For single-IRQ platforms, mb_irq[0] holds the full combined masks with no
functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 61 +++++++++++++++++++-------
 drivers/net/can/flexcan/flexcan.h      | 10 ++++-
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..32e4d4da00a1 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -957,14 +957,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,7 +1073,8 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev,
+				 const struct flexcan_mb_irq *mb_irq)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -1084,7 +1087,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 mb_irq->rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1114,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, mb_irq->tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & mb_irq->tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1129,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, mb_irq->tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1232,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, &priv->mb_irq[0]);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1243,9 +1247,15 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
+	const struct flexcan_mb_irq *mb_irq;
 	irqreturn_t handled;
+	int idx;
 
-	handled = flexcan_do_mb(dev);
+	idx = (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
+	       irq == priv->irq_secondary_mb) ? 1 : 0;
+	mb_irq = &priv->mb_irq[idx];
+
+	handled = flexcan_do_mb(dev, mb_irq);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
@@ -1473,6 +1483,7 @@ static void flexcan_ram_init(struct net_device *dev)
 static int flexcan_rx_offload_setup(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	u64 rx_mask, tx_mask;
 	int err;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
@@ -1494,20 +1505,35 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
 	priv->tx_mb_idx = priv->mb_count - 1;
 	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
-	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
 		priv->offload.mb_last = priv->mb_count - 2;
 
-		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
-					    priv->offload.mb_first);
+		rx_mask = GENMASK_ULL(priv->offload.mb_last,
+				      priv->offload.mb_first);
+		tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+
+		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+			/* S32G2 has two MB IRQ lines with the split at MB 8:
+			 * mb-0 IRQ handles MBs 0-7,
+			 * mb-1 IRQ handles MBs 8-127.
+			 */
+			priv->mb_irq[0].rx_mask = rx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[0].tx_mask = tx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[1].rx_mask = rx_mask & GENMASK_ULL(63, 8);
+			priv->mb_irq[1].tx_mask = tx_mask & GENMASK_ULL(63, 8);
+		} else {
+			priv->mb_irq[0].rx_mask = rx_mask;
+			priv->mb_irq[0].tx_mask = tx_mask;
+		}
+
 		err = can_rx_offload_add_timestamp(dev, &priv->offload);
 	} else {
-		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+		priv->mb_irq[0].rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		priv->mb_irq[0].tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 		err = can_rx_offload_add_fifo(dev, &priv->offload,
 					      FLEXCAN_NAPI_WEIGHT);
 	}
@@ -1531,7 +1557,8 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 		disable_irq(priv->irq_secondary_mb);
 
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
-	reg_imask = priv->rx_mask | priv->tx_mask;
+	reg_imask = priv->mb_irq[0].rx_mask | priv->mb_irq[0].tx_mask |
+		    priv->mb_irq[1].rx_mask | priv->mb_irq[1].tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..22aa097ec3c0 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -75,10 +75,17 @@
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
+#define FLEXCAN_NR_MB_IRQS	2
+
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
 
+struct flexcan_mb_irq {
+	u64 rx_mask;
+	u64 tx_mask;
+};
+
 struct flexcan_stop_mode {
 	struct regmap *gpr;
 	u8 req_gpr;
@@ -99,8 +106,7 @@ struct flexcan_priv {
 	u8 clk_src;	/* clock source of CAN Protocol Engine */
 	u8 scu_idx;
 
-	u64 rx_mask;
-	u64 tx_mask;
+	struct flexcan_mb_irq mb_irq[FLEXCAN_NR_MB_IRQS];
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
-- 
2.43.0


