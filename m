Return-Path: <linux-can+bounces-7386-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHGQJFlR52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7386-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE243984D
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBB273063A33
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114603BB9F8;
	Tue, 21 Apr 2026 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m0gyD5p5"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1713B8D76;
	Tue, 21 Apr 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767183; cv=fail; b=maxKGU3pTNeBhjCow09u6cikupNJWOilSWYxFd/qCP37CsolZm1Qke+2FPohTtzt6fqPCwlhNEidHbNpeikyfuO/0i0XhIkxdUU+HSjdjbLO00GXK4vzKiSOxsSSpOiIzPt6ZmhMmvumFWE6pU9nGjUD13jgTcF6CTdrYqkjQfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767183; c=relaxed/simple;
	bh=qzems42JZDALtZjOyylkBxSamEuZvhtzQ6EdLzhOMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrbiOt9rCPEIcfemRZzHKND9XR9QfgAMWBwGD7MMPAuDTF4QqQG6WHTKpi/UFemsdBtS/5QQd/LZ6600foTfewZmgkKzV7dhLEdA6nvlIoFKLq6whQbq5Z2YPs869DpvH3VQxxqS9OUGj4ujIcfZHu78zpHiZHuIGkf+GLuSLco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m0gyD5p5; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLTwOPuVcF1jI6GVm0Ux9Sm3pu14Khg0LgNyoZL0y57zRuDBhyVQhqwZIHmE3uW8VyOw3aFWOF5iaU52L2UiuEUIAgz6Lx5eSQ4JSHuQF2fwuNBg9Iz0wOhP6ilatBJ4nluMhfSVKNhfxIbplv5k6CQ1DqY6YDYkEzNLKUfI6wQCnxu4xGllu89WDKv0xFHsNf5+YzEJjtJ1EEj4KIVVr+J5zGg/7rAz2Jx5jXFUs2PtMtXIfINZDPj4oVa/iDvr2XeJ9di0CUQx0tYCbxpg53fmxT4HmhpgAAV8L9asvf6hirsZKIi11RVQxM96TjINQEy327+U82MSd9Lpx9URJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=oDRtSOzjoaPalt+duVoUr+i4zmVZuNzbM9qLj7dw/0VjGmSHhlrFMpMqSMi5WI7gRDzpr4ngXS0LU59LiNUgRXDID+TBjtbTo1jghsQm4hHrnyS3/W3YLTblnPXTIQdNlEUhtDLCRNrE+J8utouAW2phN9zK0yfzC4Zp77IWqFTWeKBsPIRzlFElM2Aa3taDYO7JYEV5S4UmLDGfcPGr40MGOC9ICAs8uAPg7YCECWfenIMf3CHL2Q3vqJjPwdVwDzpolYkkiIjcAJ9mAoPlGNb4T/gskHh/+ese+6nUVo8NyebAAqqa1eNXG546M8IKf7eftiZx7nLElpT8aXHLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=m0gyD5p5dKB9uTP9NCc40SyHCr9fe5fMWpSJm8BSgVFwUdZxrrKpoeGoUPVbEacFmoI/0qIxfmplM8lx2xw7qldThLJEcr2KrbBjkSTUyu/mIZC82goPeDFakoDv0fofLCj15eTrNi9j2gdSOze35h5MGrS869dpHB8IScjzywJFFf0b2VEXrj8vq1njM5dZVP9IBtfPa0WjpQEnZrfYktBlNfzMC113Mw2NsKU2lPzUlZ/iWdLO0zsC7JNWf919e5M2UMB7UH+Hp9j6xfwoRjHu4V/x28bgdaZ1zm5ou2GpMTX+XzHje6jPGR9fJTwTINkpyhZuqrEt1GXfoRyjdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:13 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:13 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH RESEND v4 5/8] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Tue, 21 Apr 2026 12:26:00 +0200
Message-ID: <20260421102603.4122332-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 876e4e0a-67a0-4774-308d-08de9f9069ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 Qd448C1XZzSQrLNa1sd7XaOa2Me51Tov09NCQ6RswGm3xYI1HbmX5Tx9gxHhr3UWeMzjBvGhIru30kfRdTwXqqR9yBtw3xRp6UGgpqpZt29g8TCv1qndvx5DbjrfK4N6RmV2fYc+32zd2lkmItQKokCczrzCnrI4YhuCmvf1ORnZbqOFM5uC7bx+JNmax26K/qtGBt0cvj+8E3xdh98qL/C7vO26ksWquVC5hKCdGsygTmz7okGe1aQthZwDgGgESD+Yt2OVufyuMtMu4rJp9LLEiOut0e//oeJ3fodQGVP1jH5f19f+RL1pRoJkpmAvzOYXW7YYQJkTEsnGEzDaMwHdZ/167fpcW//IT/fGBVyDfyNLb5wFDe2yMhcFlPt8YlQbSvigaObzS5dq5APdQs2qCulJA0QHCBYr3+cwWVBgxHtyb7eZD7yQDUB64Msc0Qgbbj1efP+Nfref1kTbGUkgdzgEbdh92/h/6bgotXetwy0Pb6OFMUau81REdJbPMWonPEdRWOyDAt2aN0KrwKx9srQeecjIlojeOvBWdoSqdzyONfzM6LAtPuh3VQs9hV4v/YkdApUi/RL9PNijlkCkYtmAquTVS24eGJSVtf3SlpT+ktLGrDIHAjKk5x4p9eW61pxqiZYOVOvMGu+HFrG5TcFNuROG/4ndd3urmunhpCZA+ZOPLWhukO+8+n+SCkrqr2SIcsAuAZcvq/oWTAHm5wuRZev+Z6B/8fRL3ic=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z25wNzhlME9IQjZOVFphQW9oM2ZTUHBobTc5WlI3Q2VnLzZHNHdoaFlWZFYw?=
 =?utf-8?B?ejJ6Rm9mbXVNdGU3Vnhqc0trWUtjZUNldk91L2xtRUVMZ1JSclczY1lsVkZu?=
 =?utf-8?B?bzBYSjBRSUs1ZVdMSFk3NWEwb1ArZ3ArWWxnbXp6UHgzdEEweE93MVVSKzFl?=
 =?utf-8?B?REl1bmdESWRrbmY1dENwT3VmWHp4VXdJNVZwNDQ0VDB2K0diUk9GNVNqaDU0?=
 =?utf-8?B?Q1BNMURoRm54aldKSzBLNVUxMUR6WmJoSGRrNTVtckRmcWd1NjFnUkY3SE5z?=
 =?utf-8?B?dnBuUU1Kc0R1Q1NTNDF5MjZ3QzEranU5bDNjdGxZUC9WSDdnNUxyaFNtMTJs?=
 =?utf-8?B?bW80YXljSXpLdjlLamxTTG50aGYvT1VjbG1sZTExNFRiNW5IRmxJTUV1Y0tt?=
 =?utf-8?B?QWFXUWp6aFYzQkl6UFYvdStnWmdVUHJTWTY4M2JxdGhuS0FYMWJqakZJRFR6?=
 =?utf-8?B?UDJkNkxRcFpxYVBwOUFMNTRQU0JqdnVpeHFVYmpUbWRFM3RSNU1LeWpSZ2M4?=
 =?utf-8?B?Q1ZGY3NDbEozb3ZMKzVxSFRpeWNVNFl1QWFGRTVRb3o2d016Z0dVdUlwK3Fz?=
 =?utf-8?B?TEl1RjBJSUptNDVFaDBzdFVQTXFhSWR6UDdjUWxhUmFoU2xwWnJKelJUQUxn?=
 =?utf-8?B?N3Y1MHJabUZaMytUdHUrL0xKelFoZWM0UGFhaFM3TUc3cTZOc2ZSZ2RaWUZp?=
 =?utf-8?B?THY2Qytyc0tTYXFiSUxDdUh0Qzg2RlhMNElrYVp0MUVOR3pXOHBTbTk5UUx0?=
 =?utf-8?B?TUVQM21VNlU1RTVRcVRxeFk0UndoblV3YkFRYkwyV2QwYVp4dE9kMXNqV1k0?=
 =?utf-8?B?Q244VlZYYTZqMHI3Y1k2T213OWVxU0JSeFhYWGtGVytrRm1iVUR4Wmd5UW91?=
 =?utf-8?B?WW5EdFdPOE15bG1yVnM0MEsyWVdkZ0VCY1JsVXV5aXBtdEFFcGd2NldpRkVB?=
 =?utf-8?B?b21uR3NjRWZLVXVvbHFtWXdITllHU3QvRWlYclY3MjR3RzNicWJLbGw1NWpx?=
 =?utf-8?B?ajVYUkhSaGpEbmVjUncyY0Fsb3ExWEZiRldxdFEvZzlkWWh0UTZYM2dqWFJR?=
 =?utf-8?B?ZHlpWXZVU3pTOFdneG9sRG80OXhZb1p5U3A0WDBpQVFPbitKU09lWHQzSVRy?=
 =?utf-8?B?SXJSTWhnSWxEQ3lOQ2FPdi82UnNtenR2WXBkang0WUlTVGZxaEE2NFFIS01D?=
 =?utf-8?B?SzRFWjI5UWN3WHFyYUVtMjdWcVg5VFZZMDFYcjRJclc0blc5WHBhTzIyb1Vz?=
 =?utf-8?B?UGVucHZJTFJYN3Bkc21NcGFHZzZnSCs5UzRxNHkwRlNHZGdkb1VZOGRXTEsv?=
 =?utf-8?B?eUxMV0E5VzNyL2dxNXMwQ2FrUnFHMEJKeGovM21DRXlOUUVPYXliVXVsY2pV?=
 =?utf-8?B?elFldmlHdXdhLzd3Sm5pdFFpVGRWTHZMaEVIb2ZJdW9BT1hydTZxZHExWSts?=
 =?utf-8?B?SFFkV0NNV0ExWVRaZklLNE0rbERpSU1qbEJObGVrTG9ES2N0Yy9DdGI1RzhC?=
 =?utf-8?B?RHNQRHRCY2ZPYVJyQ2tiUGJYSHF3dm5BQ2NFaGpGbWo3dzY2WE5ncVhFRWRH?=
 =?utf-8?B?b2ZGaFJUUXg1Y1huZ250a0JLQ1kzOUUvdlhyb3RNYm5EN0xuS3o1UnVwRTQ1?=
 =?utf-8?B?VksxV0VDWTVlLzVSTWhHMTN0TFBqUXBCRlhVRmMwOTFmYk95TDZzcHNLOElu?=
 =?utf-8?B?UlVlcDFVNGxoM0RaMTdEaDY4VE5lRnNkTnI5SndLNy9BSDNuUWxMbEhDT2h2?=
 =?utf-8?B?SE5GdUt1ODZ1RFJKV0hYRnZiaEJPVDJGU0dqVkpOOXJuUnVHZTU0VkVPdWpT?=
 =?utf-8?B?QWVyK3BXenJ1cHV1bUFDcWhjRWUvdDdNMm1xcGdTemNSaXBDNEpDZUpRZUVp?=
 =?utf-8?B?RHhvcWV0a3JtOGorYVpTRzhDWHIxc1ZvVlFLZWN1bkFreXBXcFZETEMzb1Q5?=
 =?utf-8?B?UG1NMnhEM1ZqL2hEZzVkdVMrMEdmVStpb2xoTmRkTnMvODlnVjNmZHg2cjRU?=
 =?utf-8?B?MzNEenBEemRCRU5EUS9scng1VUV0VUNsYlZ1OEp6M2h3V0lOQUdEMUhxNnNT?=
 =?utf-8?B?a2NYa3hnZjh2a3hhSlkxZE9UcnhrUFB5dVc5cjJGTmttQkVVMHZDWFBKQTc2?=
 =?utf-8?B?bFRyZWNpNnhmVXZaVXBvWlhLUmpCSmhBU3R6bHNCYmhhL1oxMmpjeWNZeFAz?=
 =?utf-8?B?YkdlZG83bXdaMFJVNWxtc3FZenBka3RncXFPUjhIUUt3NWFmV3VBMHNnZno2?=
 =?utf-8?B?U1dkeXp0NlJLWjkzVjE1Q3plZFZQVTZJdWVnQzkxejJXZzVrZHJ3T1BRWm5t?=
 =?utf-8?B?VElSMUVHd2xmd0ZmSmpFQWsrbjZIdHFhb2V1TUNHSjVaQmdJVU1oRGQ0eC9y?=
 =?utf-8?Q?CLWH670ZXNAjIOQg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876e4e0a-67a0-4774-308d-08de9f9069ab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:13.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSj+gDL/GiVuyHZz1piI3VacEDj64cmCozvkcLBm5YGvXBocVrogA9ws8uKgFAASKfOb2B8zEDJOnHoJPTRbkPlSLp6ujEL6C5LgQ08WVDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7386-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 01FE243984D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

Also extend flexcan_chip_interrupts_enable() to disable/enable the
new IRQ line during IMASK register writes.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 54 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 32e4d4da00a1..23ddf7910641 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1293,6 +1293,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1549,10 +1565,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		disable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		disable_irq(priv->irq_err);
-	}
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		disable_irq(priv->irq_secondary_mb);
 
@@ -1564,10 +1580,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	enable_irq(dev->irq);
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		enable_irq(priv->irq_secondary_mb);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
-		enable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		enable_irq(priv->irq_err);
-	}
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		enable_irq(priv->irq_boff);
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
@@ -1891,7 +1907,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1912,6 +1929,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1926,7 +1950,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1958,10 +1983,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2348,12 +2375,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
 			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
+
 		priv->irq_err = platform_get_irq(pdev, 2);
 		if (priv->irq_err < 0) {
 			err = priv->irq_err;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 22aa097ec3c0..43d4e0da3779 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 #define FLEXCAN_NR_MB_IRQS	2
 
-- 
2.43.0


