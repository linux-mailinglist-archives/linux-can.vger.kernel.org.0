Return-Path: <linux-can+bounces-2128-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091789D3655
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E1E1F23B7E
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAB185E50;
	Wed, 20 Nov 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O9GsXPSs"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A635155C96;
	Wed, 20 Nov 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093458; cv=fail; b=EG8WiC9zBxIo5tB7ydoNG8xb5J2kWyXrjtsFw5k4QAbRFGsM/S8t+kTdGnFXix6zH8iAIPCToycE8B1lws/46o2EC8YL8cO0DDTihlPud9WdVEa+FnPCkW0eeawNuHl2FVlbDmX1kHblIKbyZHd+8vsUlkPJCBOKoweATc7c508=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093458; c=relaxed/simple;
	bh=QgtDWtswy5svuiw8euBCBpoQq8Yuj4NjDET/kXsyGcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=utwjOTAUhRTSQz79TprvaBHKPPQu+Pwyjn7DqgCofOf9XvRr3YJjcG28QslytHjffsmmL3mONn7vkyKkHVNtNE1nMHwoC81Bb4RVLegPTsaYt8FxgmU5kYewmYTj7hvyfnRQYkIguVylcAkqllpn/ck1iAx7YLVheyy3gVtopz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O9GsXPSs; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWxbAHG1rpvESLOHjCuSWmMe9EoMMBIKgkU7+/iuyP2Sp1jEYVYtRzdYcKY3pfudOke01aoOf3CQQwN+3RltZHGsWoGNaTRE5b7tNWqUx1jyAbTFjILS5O8A+IrLD/Dr/jp2qXrchfnEVWvXoJ3f3vJs5BIRoAC5hqS1e9F2OzjJz4rH48YFr5j39yWFnEcle2GrJD/wXIwS+9a2pVizj6ZypKeMwYqhWHT+dDJ9MZOXY4Pi3zS29flwT6YNHuprhQfPGYpi0+ZI3A/nusl3zZQCHjvAQ6fJR92fzoW4VWbhzkgfbK+UUgSMtfqn5LFqH+VUayLg5ZY1oL4kOAUX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ3edxkZjSE4JcVMVSNHEEVgVdhNXjcOzTZX09ehHiE=;
 b=om2LgO9Tkp2Nq8tJGllcOFqfQmcbHR5+KMi+ANB4ssp9jcGphzskLgZMpSeLESTf4PCU2h7mq7LzLT8xlbA4Bn77erlra+fMLelDNb+zhFbjpcQk8xDw6/bRP7tFEaw2EHa3UkG4ogCB+dmLWExmgQNuWDK9gvQyz6Mk1dVNlutHaRNB0x/0HtDQEaeKdT+8uP/dbV9ULuyLWWXKRlO+69/lmIsTqsIVHVO8plIDWSSrC6xnKLcgBINZy2hkxJD2ko7CQahvAJqscPvg7kT/d2ZQBy4r+sxkMDIzlfqeEmNcvnj7gIFeWtyZ+5uGtJXV6p3nt0JIB3W3A5iwuKE3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ3edxkZjSE4JcVMVSNHEEVgVdhNXjcOzTZX09ehHiE=;
 b=O9GsXPSsFFgTHydrWqsk/EM7yTcoJFgsG5EV6y/LEhNm3PkGSk/Dndn2pNwfOBfijlHPkzJpM9wSnJgGwicCMgIDlye/NpOcuS6EtLAbJCkCrdNYXWrHR5oXbb1kEjJc5Kt697Ucwu55mEEb/q1OcUr+rWq+7XP0pNh2glgKpwPoL0mbofRDr+yr3+cXJIrPQjn8nQ80STuYUNFaSXki0q8sME4cXrdfsHZh6vjdxL4FBZBKrb8uaAMe7IL5HcmDew37G1ytGDPukPyjOL8RkGmOkzCdSVaxKUUz6lQwMvOPiq7x5ROu47l5v7UJrgU8LSaftGklYPmK1GV9w887NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 09:04:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 09:04:10 +0000
Message-ID: <48f662ba-a06c-41d0-bfee-abd0b9d57389@oss.nxp.com>
Date: Wed, 20 Nov 2024 11:04:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
 <20241120-loose-amorphous-manul-49ded8-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-loose-amorphous-manul-49ded8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: a2510146-096f-4cfa-4308-08dd09424c18
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmkzUlI0cEtaRE4rRlh4Y2dLblEvNmpPMCtxcWlQY3Z4aUtOSlIyem1rZ09T?=
 =?utf-8?B?QkhQLzl5bWVsUVo2d3l2U1FsK1NkcHdja2wxd2p1M0M5ZmNWdGtuMHU4M3VO?=
 =?utf-8?B?MVlpOXJ1Ti9tK0QwMDB6bmtITkVFWmpHeHV6ai9nRk1rWVBlYVdOc3l0bkJV?=
 =?utf-8?B?VWZtTE9oakNTajUrZVkvUTEzZFZHZnR0bXFZdHRaTmN1TmkrN3dXWHBjOGg4?=
 =?utf-8?B?bnFaaUFFNm5XNGpiYkhUQlFkSEhFZzVpNHNCMkc4cE1XaGRRMjBuSHpGODNU?=
 =?utf-8?B?dWZ1bHlaNzcxaHkxQjFpTVdWbUs4MTErOGZSUnNZcU5TUE5BN2tDOGVsVjhl?=
 =?utf-8?B?SmVpQVgrRHU4bko1enJDZjNwOEE3WERUb3FKL1l5dmdBVTBQMUVncS8xNkRl?=
 =?utf-8?B?bDM0clFKNmJPMXQwNkpEaHpCd2QvNmpqZGpreHdNMnRKNFJBbExDNTUrTmw1?=
 =?utf-8?B?OFZWaXJmcmtqWFVzVkJSeHBWQ2ZKVWdRUlRYeEZ4MytuMXBQSjYxaVZ3WTVG?=
 =?utf-8?B?VTI5c2xVK3BxVmNVUjBoRm5jbXc1QWdHNlUxRDVFZG54UU92VGQ0OHRvc1RC?=
 =?utf-8?B?T0Y5cEJkWnFmeWhOMU1ORXBNd3kxTHZkcUo1YmRKUjNTekY1UTQ2Vzg5OWhn?=
 =?utf-8?B?ZWozQ2xtWTA0ZUNRbFBPMGRyY3VwTUhaMzlKVGhzN1RpKzhjM0lNWFRyYUV4?=
 =?utf-8?B?V2J4MWFKWEFxcElvNlgwakZKenU5cUlVdnJwcTFBOTlFQXNkVWRIWC9IUjBo?=
 =?utf-8?B?Z1JxclEzVFVnZy9oOElmU2p4Y2RuT2l0eW9vbU05UTNycWhVNTYydFZCTW1X?=
 =?utf-8?B?eGRPN1BML2tOOXhRb3l2WmdjR1dsRW1mUllHSGs3Ny9iNllyODB0bWRmcHdq?=
 =?utf-8?B?ZVdiaTExRUdGNWlXWUZGcTFWaXBodTBQdnlOZmRUdlo3SmxvZzVqd3dUN3k3?=
 =?utf-8?B?Um9EZ0hXUDZ4MXZuODRPOFFrYk9OTHhpNnVoU09ZWXoyT0xOTTVST1dwRGFV?=
 =?utf-8?B?bkFmRVBLNEhTWDVBNFdDc0VteGFsMytVbFliQ1FENm9GQUpWajAyOTJRT0p0?=
 =?utf-8?B?R2dOSU5lYlR4TlFWb0U2cE1wNGRjVmdVdkRQK1JnTTBWODAzMDJ4VlpMVFdk?=
 =?utf-8?B?ZTB0dlNhbEdPK204RGlSQTZwRVBpSEVYTzRkSHVUNDJhZ0xPRko2dTFVa20x?=
 =?utf-8?B?NkFJTmRDOHVZSVAvL1F6MUl3RTU4ZEhpdkNDMjAzSE8yOCtSOTBWZnNjVDk0?=
 =?utf-8?B?M1pLRGg0OXliQ3Erek5YVEJDQjFzOHA3SS81aFd6dFJMVTZOTFZneXB4ZkRp?=
 =?utf-8?B?K0pOeEpncWRTR2xtRjdraWtmWWVmdGFucWw0OUNOd1IrVUhoZ0k4TVZjZWUr?=
 =?utf-8?B?VWxxeXhldTVibllsNlorbUJId3lWOWtBNGt0S3N4SVRKRHNvcVY0ZHZnR0FN?=
 =?utf-8?B?aXBYTHRUWGYyNlNBazgrbEFqYWJwdThMQ1BkTms5TDZXeWp0MkVWemxUeXI5?=
 =?utf-8?B?alY4NlpYSTJxc2JHTnJBRUV6OGdUZWg0bG1JV1Z1MHM0R1pRV2ozaFdobkIx?=
 =?utf-8?B?dTBuYXk4UGphUmFCMmV6VWF3SVNEeFhScWVKcFZjcG1DZmZsY0YraVRTL3Rx?=
 =?utf-8?B?R2dSa2tqWDFWbUt6d2pZOHVsOUx5cTdrSkIxMUpmQklBTGs3eFNkSmdVUXJL?=
 =?utf-8?B?cnM3YUJpNGZNSE45SEl5SnVKNjFpUngrdU1aZVdIQWRIdVB5Wlgxb2JvYjFN?=
 =?utf-8?Q?0agxLQIDosdEPJ2A6TYNhFG7ZtSnv2/w2WXF8z3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNQUzEyZHBVMFphdFJxQXBjeDFhNVlmdGZ1d0R3UlcvQlVhT2pZdGZ1N1BM?=
 =?utf-8?B?anZrdVRXNzNZKzhaQTV5UDE3WXowNXVNWGNIQ0ZrQjJVOFM3WGowMTFac2h2?=
 =?utf-8?B?cTBUQUdPTUl1ZTBlbkhGdUtXQkdYMlM0WVFKUXBQTUtDaVVkclJCejM0S2VG?=
 =?utf-8?B?UURGQTRkTitUa0lBcFhmRGs3d3pwZldhQkdvOUdqV1NLdEpRVkU4bGFyYUJH?=
 =?utf-8?B?WVQ5NFlDbXpRdkREVHd2WVJPbm82Mm5UYzAvRmlZcUF0bW4yVW1qdmhjSVlZ?=
 =?utf-8?B?SGc5RHpucnZkSDFneHdJTDFtVGF2cTZ0Y2hJMWZkOVFIMkNXTUdBaVhhcWlv?=
 =?utf-8?B?UlpTRzNqOFpBV3JXWFJuSkNnZlBEck5DV1dOdmtUOVp1WXlCQ3VVUytYZEYz?=
 =?utf-8?B?TW9jWVF4blpSTWJzNkw1OC9lR0pWRjViN1hrWGJVTnZ3aGhZdkwxS1UxOEYx?=
 =?utf-8?B?bFZKaVFUMUZaTVBBcGxwVFZNOVJIYmdCVHVQZURiK3d4Y1J4Znc0L3ZZVW1R?=
 =?utf-8?B?NldLOGM0K0JFMDFDc0RzRXhwUktPMWtyTk1YMUZ4c1hlVjAyZmUvbm9JelJy?=
 =?utf-8?B?VFJBV24yNFp5Ym5nY3g4ZzRLUU0raFdmT0xQNFU5SHVTNWJGaFJjcUFySEdT?=
 =?utf-8?B?eklXZzcvUnkzZkczNkpGVDhXTERVUFpKOUN3d2JBVlZyRnE4U3B1elFia3NP?=
 =?utf-8?B?dlNodDJpY2RBeEYyYjBOSVlOUExWSndiQkdZRFlodkk0QWFFRXNlTDlwYjkz?=
 =?utf-8?B?dlArUTNkRk9xZUZBMXZDNFNMNEIyRUl6cnBtZ2orU0JGTFl1M2gyOFI3QUho?=
 =?utf-8?B?SVRzS3dPVzlod3hGODc3WU1VbTZCNVFTMDFZS0RScXF0WkVscnROWitWUlJZ?=
 =?utf-8?B?VGh6YjFsdkxhcUZ0U3F3ODd3NGxQcFI5ZS9xUGJycm5rUksyT1IwUFVYQ21n?=
 =?utf-8?B?SzMzaFZqbjBydCtGQmE0Q0RmbFEzZ3ZTZzdESkVpTzNIdG1Oc2NuaERhMnJO?=
 =?utf-8?B?YmNBTjdIejNoUVd3K1BTcHRIZjc5clAvSG0xSGVCZmpxb1dXMkF1Q2Z4U2pl?=
 =?utf-8?B?eUN6MkhqdWtsSnBnYUprVDgveS95MUl5a3UyYWxmTFVPM2xlWThSU2tGbi9r?=
 =?utf-8?B?alh1SnlQSzhuWDlWeEllNFpOcTN0dkx6ZERpbjJybGFYd3A4alVLcUl1clc5?=
 =?utf-8?B?OEwvSFczaHdkUHdqNEdTelZkbUtwa3FHaUJxQlJVdkFHS2kzOTg3M1hJWmFv?=
 =?utf-8?B?elVHMmpZYUlLd1pnRStCNldwVlZGMFJSeWhsa3l6Vjh6MUVSeEpsNE5lV3RP?=
 =?utf-8?B?dDU2L1lSelpLaHZCdkFXMXhORExGMWx5U3BXYmw3U0pXVFQ0Rkk5SnNtbmZz?=
 =?utf-8?B?TW5CeGQzdnQveDFtQ1hQWDJVemV5bDE5VlpKL0NZaTkrR1BZSDZXL1NEbk4w?=
 =?utf-8?B?aG9wN08ybm9sMC8xREZnbVRzNHVwcVF1L1pIbS9aMWV0NlM4UXd4ZTY1d25B?=
 =?utf-8?B?YVNuNFc3YXFWUThSaGt5cnc3OE1tQWx5RHBsdVZCcmpPdE52cGFldXYrZ3cz?=
 =?utf-8?B?OXZGeGRtanFPS0FPYzk4UXEzSElhTit6bE5wbjhaQnVKZld2N045QnV0WkN3?=
 =?utf-8?B?UFN2Mm9Gd3ZlT0NZMHhNZHBrbnIwZ0lQellTSnc1OTFjb1hXREJiT2puTEYx?=
 =?utf-8?B?QXBZTnlaYXE4anpCZzQ3Q3M0SW8xZGZ0UGtmZUwrZm9Xd0Y3R29ZTHA2amxl?=
 =?utf-8?B?ZWpnVElybnYzNGdlWnZEeFM0dXUxQkM2cGx1WnU4WXZITFNNcDJBNG16VE5O?=
 =?utf-8?B?TlNWSEViOFliS0o2SjJwTG00c3RLRWpTbE55T0ptMEoxYUZoR3duanl5TEpl?=
 =?utf-8?B?UndFczQrOXhWVm1aM0RibFdvMGFpMVlnekpCM0V2R1Y3TVUwaW5YTWIzSUNm?=
 =?utf-8?B?NUpVZ0hyRjdHV21DRXNVK1BmZ3JMakY5eXErbzMvdWp0RmNHcWRZWlJwTmNG?=
 =?utf-8?B?bEswWEFUckd2dDBsR3d4aHZPcVJBc2VDWGtvam5NNzZ0eVBodDRjM2t1WTVW?=
 =?utf-8?B?SitiUk1QRmJWZlZFcm9aK2ZwdGs5cWYrdWptTm8vZ3NEaStlRXlQNW55aDNP?=
 =?utf-8?B?Y0FOcmJHNStUMFE5cm9NdUIvamZaRGpLclBnME1RWWNkaWY2Y1NCMUpLRHBJ?=
 =?utf-8?Q?MCkC4pqEjEVLrzgrptZ5XWQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2510146-096f-4cfa-4308-08dd09424c18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:04:10.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gT1MzYmlIVQTZbXI1/nrCPu/bPHl8bNq7OHBHEplCop4ckH1S+O8oyjeJbiVNaYKITCbdvC43jD92fbvBrf5pro7NulEv7D1gMsAr2koAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556

On 11/20/2024 10:49 AM, Marc Kleine-Budde wrote:
> On 19.11.2024 10:10:51, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add S32G2/S32G3 SoCs compatible strings.
>>
>> A particularity for these SoCs is the presence of separate interrupts for
>> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
>> same restriction for other SoCs.
> 
> Can you add an "interrupt-names" property?
> 
> regards,
> Marc
> 

Yes, I will add "interrupt-names" property under the if condition from 
'allOf' in V2.

Best Regards,
Ciprian


