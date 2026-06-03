Return-Path: <linux-can+bounces-7739-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mL6vFLnUH2pxqgAAu9opvQ
	(envelope-from <linux-can+bounces-7739-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:16:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7668635144
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:16:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="a7/pWoin";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7739-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7739-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 440F43042E5C
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269039D6EE;
	Wed,  3 Jun 2026 07:13:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338439B4BB;
	Wed,  3 Jun 2026 07:13:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470833; cv=fail; b=AHAA70qxYjx5dRbsm6m+icXFdvIVNjeZFvFMAxWUuH+0XrA6S4B2D8XhyloztxgqIWfnCfN09B/I9mjVzmagpFiJLAZFY6gHZ1Y43cdA7gC8lGTuNVDHjs8jHb33MSYHAxNl/HFMKkOl8FrOH9kobXD/WNNvDfVSF/hL3BhfJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470833; c=relaxed/simple;
	bh=8EOsHs7J6ANm39x00dNUt4uy33ChTfGHoogRmHAEvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxVipgy5uf8lXJ9j3qN+kan5ZV9/q+eGC2LgLnUDFrhcyjua+xTjAlQOJe826HoyXwyzwk7a8i5+bjE+lvAx9FGC/h18VQRbb1pg84ctNdLC2+tlBqz/mesmY2p9ujNBNgL7IsB3KHGyYmmrZ0oJ231ctTqjuTFO5i8hUkP+FEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a7/pWoin; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQn1MGZZUyrAemv8Y3Pr0Exvz3M4mgcXy0PZrD4lUU2KXVCpLXZdF0lgK6bCPT2JIECgXSKuU5v1IANhr5xWp8tAPZgIZpKVvKecjy9tRT+IhcamrmdYqCQGnH6ly90eP0t+/SfZ1Vu4WEMZICGy1PeXUMzQnBG6PLxHeHZzVYLPVn7583NUjWFvtCboHGy6WAkCHl7PMGVuhPRJ8x80Styz9fd0pmGOo5EflZ6RTrA1GcIt2N+0mwZ0+17AkKHttRoC+mq7BCnUWYj0SUZokUwsYVyYZmBrPAqtcZ2+gTb7lfDgs55/pAIyjNf6ImEQ7us0JuyZduBWlW35qdJgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=kw+saTawsSMxdVeJkoKwvLw8ZvY2kvmwITEpiQGurny9v/TOSE7MrAjAZqPIpG0zb8xXygPXf2T+IVwUSO1WaKxQdA/wWVctKyUGYu3by4DHx34STSIBxwlF1DHly+enULHjBGGSbQvMylfEz8LBUtyNGbDECq8yiNb6LXvBJu4QOh5JJpMor01ckqzJ8Dyhq6X+v15470rSNBzPJonUEPcnalQu+VxZn+mENBhknInWht4+FcmzJTy3Z1JJRq4J3SzE5rDEO5A5mZLd/y71bi0bV7GBQAtfk+Oq573SLPoq6EGzh4mYW+5eZyRMjZu/vmG1OIEhbCrXDyzGLHwz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=a7/pWoinosPVt1gnE+Fjl0RNUbHfGOswOXOHHoPRu503/TwYM3yNgtgU31DOK1DmV1PgOhbS/dAXq3uF3fwaTDyCPL93m37UTKJXdNaZD6rwDHduj0cDqAMhOrrS2034CBOmwvDw32pLCJubg7YgmwktnFbZYNFTm8ieBYetPHGLyj4R5NZwqq0klB+O2gVBPtljjbAsTRnmyrQ4lojMX6HuSbefhSqpcQQbS9vHVFAa0JRq1Cvdcw2GKoct4pYnO1ud/eRkRUNloezF7FaGxmhRBux+e+ft8K6LdAqOkDo+qeyQhAPa0K/IuZ2wZ84/3bHKF7BjRr/0glp830/THg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:49 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:48 +0000
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
Subject: [PATCH RESEND v4 2/8] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Wed,  3 Jun 2026 09:13:36 +0200
Message-ID: <20260603071342.641874-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ad128123-a4f2-418f-c22c-08dec13fa80b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 r0kwk3sfzggGfhtlkLxc83W4bL0/gllpK8afsX9gY9lcH8nlCUu0cE0vAalmn8i6TzA+5YWCq8ifcDNmunf8ic1EUh/9emOP38o22ycgOYNxOFBT40CAIYZDGRwvCclsG/cpLdSC8cOlf4f6WRz9QeEtTQ/z58ZDEXpSb9ht2K8Bx64wwZTzoq1g0OzzHxrVUlLk73n5dqnnIZtYyf/ckNvjpQyY9NhEPTkI8L2OSb7pbUVfQf3KxU/plTmYjTACC2yxdvpDy7ASLtOvIzwGpkGe6VJKMPmc4lqQCYJz0QzDY95oaeFG2r3ZnR+E1/Xb73w6nRfXn9ptNsjbRsNWu7cVroqWS+6Lo6EL6F5qFzGzABQWDnEzetLWaPOlqon7lpWPUxF0LYPIYquYYIsQZWIg09SQzZomtoeQBBPiuduoPkKVOpoC9VnGdogygsTbpVrJkxSlaCzNBuvyIjnNr/DdcZqBuUQ2yADHk+qJVKXHhgabM8OE7sbnYDGreU/Jv+m0Hbyg1IYpGXiW5bpW4qQl7Ks4PRBTx6elvSggQ+yw2bLysebWZ6qFWvCv0MomDLwv2L9GV6WFm0cqrCW6kwTEKFI2tJutxghKV3oM9hWv6Ke3gkxgFXfqwLhJecE2N0skGDvh6eTGG6uBM9Rn/mvM+1p+PfJhG2tizsaZCOoB9unZa1xyCyddNPYgM3MW
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SUsvQ2lOMUFRenR5N0dZVXI1bm5IcTFMbW5ScUlXUFN0VExXMWhBSFBOMG5l?=
 =?utf-8?B?UlhaTWE3TFdRcTVqMWRHdkVicFVzdGxOdmM0QUhkaElRSFNkaG4rYWNrbHIw?=
 =?utf-8?B?MGtrdDdTNmJRQXZ2MnZtMEx1MkYvMUdMa0ZKdjlqbkp4SndKYVdtcUxOZEdl?=
 =?utf-8?B?MDRpU1VDR2oyczBjcEpVZnJleS9pQkdWU0lialplbXlZQUN3VTd1MTFYb1Nm?=
 =?utf-8?B?REV4Slg3RUptdjdvRjl3TUpOcWJDUFdtT3FsOE4yQzFJdFRldFE1bTQxY0dH?=
 =?utf-8?B?R200cFhrd2w5Y2R5L0pFTVhKajhIb1dVT3FlWE9LTDN5bDl6Y01RSEo3ZEVR?=
 =?utf-8?B?V3luZmEzYmVvcEl2QXJ3WnBWbmZJb2N3R1QxbE1zek1SclpnQmZadHV0NGsw?=
 =?utf-8?B?RXYyeURLZlBJa0ZlVU53dzJsR205UXJlczBYcWxEYkVHalFCUXpwSG1EVVo1?=
 =?utf-8?B?bmdDN3Z3T1Rrc2RvZkk4RU9ONVMxSm92MzY4UkVUSlJ6OEpCUkNxdkZIWjN3?=
 =?utf-8?B?V0dLVmpJY1ZjS0xhVzJFTldtb2kyVFp4Z3RlUVdZOXYxYTE1aXBVbXdra2xh?=
 =?utf-8?B?QjRvTzd2TG5FS2FWMndrdk9yV2lxYkZCWTJMakhHbEc4S2pjZktQUTU3OGtI?=
 =?utf-8?B?NENQKzNOZFV6Ymppdm56N1dxNUEzVUt3TzVxeUVMMHVCd2h1ZnJOOUJYdUp3?=
 =?utf-8?B?cnRkUmtBdGtueHVzSlNRSUozSEwvMk9wUC9iL1A5bDNySlI4Y3paNHBwU1o3?=
 =?utf-8?B?dTZjUUU5ZHFzNGRDbEprbHlKUWlJbk9QbWZCaTkzUmZ5RDdZUGxJSkczaWFv?=
 =?utf-8?B?dzA5SVdoNXc2dDVkOXIxMWhPbmU5TlQvQWNoYWJOSWdEZ3F2b3dpSk13L1gz?=
 =?utf-8?B?N1VHRklMVGhXS2N1T284NXBUKzBVTFNnSStpN3BRTTJHSC9NVTFIWFYyUW5t?=
 =?utf-8?B?aFBPK2JOMGQzNGVEOTZrOS9qTHNZRENkTlJUMldjSk1PRHpUWmtZTjVyS2dk?=
 =?utf-8?B?Z0RSNk1YdTNjMVgreTZ2T0lxSFdyeVN1b01jYm1LUC81SDBDcVlxR01ZSHk4?=
 =?utf-8?B?TWZTU2tobFZCTVcxYjZJYVlraWpMUkFCK0pWNm9LdDgwM0hhOVBSVTVHYWFV?=
 =?utf-8?B?QUszUlgrVDdFZzRtbUtXVERtcUVXdDc4Z2NQalQrZGVab1RVZG1VNVdoRE1k?=
 =?utf-8?B?S1h3dmpTYWJNbUdHTUlsc2VNK3p5QVo4NTJTZHBuYWFwUFhrTHJlclVZcEZC?=
 =?utf-8?B?MXVsOTYwK1lkdzJqakY0SkJid2NoM0k2bmFTQ0RqTWwvZjdEN2N4NXdtY2Fv?=
 =?utf-8?B?TGIrS3UwcGF1cEEveVBxV1BwSWo2Q081SWdxOEZ3Tm5obFhhS09aMXk0R2NE?=
 =?utf-8?B?QzhCaGxLaGhuMTlTc0JCcFZRQmM1SkFuNjBIV3FRalVGZ29lcTZETTNGVXMv?=
 =?utf-8?B?cmNqajBqVWViYlpOZjd1V0xwQXN0SFNhYjh2SmVoL2xyYjYzRGkxODVnYXFr?=
 =?utf-8?B?VkYwRnRWRXRzMC9Ha050WkdGODg1ZlEyZlQ0OGJQOGhCcjVxN3lydUNGUjBR?=
 =?utf-8?B?WFFvNzdtRTR6TDZKZzdsREFMUWVKN0lSeHVjU3lBcUFWZ1FzRk50QUd5UGF2?=
 =?utf-8?B?RjRJVUpjZWlaZUNLTnZzUnl4bUk2VmlKTjl3bDJYbWlnbGxuTkplbnVTNE5k?=
 =?utf-8?B?bzFNeWREQTN4RHowVkZLekNnd2tDbnBCL3EwNi9zSGNVYllveGhZbXRiTjFn?=
 =?utf-8?B?RGlEVjhvVUlIQkRiQjBpaXdmdWo2U1pwMWpoNDBUdUdlbTNsU2E2elpYQnlQ?=
 =?utf-8?B?VGlDNWpFNDN2RjZQRGViRFRxOFR6Y25oWHBWYWxNK0RhUEREamNlSXBDYjdK?=
 =?utf-8?B?Uk9tRjBZNzNjdWg0RTNRaUdyeUpRb2ZWRmowSHoyT3pMNTZMWmFNMkJ4Z3JH?=
 =?utf-8?B?WHZNZU8wazIzaFNtMXBJbStZOFVBS051ZTRmM2ZGNWtEUzFvcWxRN1UyS3lB?=
 =?utf-8?B?UGtkQ0RmUHExUFRweHBzVWZLTG5UeUNnQWhvbyt1MXhTK09VdXZtSU9pTzRv?=
 =?utf-8?B?d015UXBmemoyN1ZiRG9YNTF5VTQvbnZUT2JkbzJkMVoyR0JMVXluSXJObUV3?=
 =?utf-8?B?TGNvY0YyREVYTVEvSnk2YnExRUR0b2RoSmdJUjlicHdoLzVob2lsTTY3TWt3?=
 =?utf-8?B?U3AwWWhNS1pWOGQ4eWpUbFgxOVFrYUNPK29qdlJsRHFobWVZVTJyZ2ZhTW83?=
 =?utf-8?B?ZmdnSkgrQy9xWTVqcUtjRzVqSXR1ZGJBLzdOMjFJREhsNzlPMDJ4cEhTWm9U?=
 =?utf-8?B?SUV3NXZLcGh5dUx4U2FVek40bDdnR0k2MVVBZ2JvVFRhZVRKMmEzVExCaEFF?=
 =?utf-8?Q?hj+08j0WSsqQjjjU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad128123-a4f2-418f-c22c-08dec13fa80b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:48.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+FTihUmVhOMuBdEEv4h/6Oo8h8rE5QujIucV5dRKLv2rVSdWybqAP6lrA9Am+KxKFvboS2j4Z7YO+zD6ikKDoYX2KeqrheY1n4Ghtb8fHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7739-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7668635144

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f73ff442d530..7dde2e623def 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 quirks = priv->devtype_data.quirks;
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		disable_irq(priv->irq_boff);
+		disable_irq(priv->irq_err);
+	}
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		disable_irq(priv->irq_secondary_mb);
+
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	reg_imask = priv->rx_mask | priv->tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		enable_irq(priv->irq_secondary_mb);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		enable_irq(priv->irq_boff);
+		enable_irq(priv->irq_err);
+	}
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
-- 
2.43.0


