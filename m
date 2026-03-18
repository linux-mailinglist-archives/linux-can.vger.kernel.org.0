Return-Path: <linux-can+bounces-7135-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KcsNYSSumnSXgIAu9opvQ
	(envelope-from <linux-can+bounces-7135-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 12:54:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E42BB23F
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AB2A301BF60
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE83D332C;
	Wed, 18 Mar 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sRm9wzTI"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6B3ACA72;
	Wed, 18 Mar 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834756; cv=fail; b=LqzxwBvsnyVl5/ZiZHBqU6jD/yd5Nbo8bRZzOpeZSS1vsR6S8uijIhz+Fz4nhPr8cNnrUuSmwgbW4b9dfYkahj8icZqzCrgXqCrTVk5cAIFx5/MMpLG5hgC/8ql8yiWCa2SdhRuaayTjPYlUru1HHQ6EdPK8ep7SKHSI8d1pdRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834756; c=relaxed/simple;
	bh=mwT554INYuESlbQ+OaHG3S0JiVks13JqS1l9rr1ssLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFiNpj2ewDNUVsz9LxrR9yDXzskqkpJoSkKn+mYk9E4GCWsf2TnZYTrBXBmkqTexKlOkt+sS9trejU6s5zExwkH1N49oq+IB8vZiHOz8I4MRm3AQSwAjDK9W3zBV5L2oQN7g1OM0NUpA8Kr5S0E9BzpDwnOB1JzOh1FboD4Q2uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sRm9wzTI; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suWWq6ivK464KALDYAofofaKXieQO5iZSt6dbs1qLjj0LjVQr2KGAW6SVE7l/lgrwhfqXTXlyyf0nz6Qdkg5im4XE8xPFLJsWkbnrUfGStr9On1ONJHC03OYJpqBVuI6xEuIR/rh6PvXLQmj5BKa7nJC2ExRfQePO4dEPBNDOnRDYU/W/JQNtxRjEiamCtUr69wo6iKGb8WgMarr0hxhQvoyCoFwpq2xi2J5W3MDRaVqHBiz1En8GvjZBEWJ1Lzj7hPEN5u8FcsHnVR0cJnIoVm20/uQUuCouP4tBKE/rn6iXk+8Mh4qWFlHOei5ihT7W14Y62LhwvcZuR03UnOTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b2or7n9RlxmYql5wGJSqbCT/pBzM9wkTqCl0KohkFs=;
 b=ma24+TcSWQIN/tdriaXa2Dw8BgujmF/cRXyAL2WXKayPS3lAJTY7dj2dB2po2PErNaO4mQvgl/lG3d1Fo2bSlR+4eVQDUG/n0iw6Vmi1NFaS7tCsfWxkpxCH8scFHGvufupQAYPDB9b7BvHuh4PF8Cq/sRs4X3aZYVTlhhfuoxcOnXu7NHgmI+MiRDy+wjVYe4F/yYXb8Y3qVRnnpxbOTGXobt4dDPVWGtCQjgN+ckRDOVD/L2delG2JmfZ017rVlK7dcxWKe/Bw9sroSyhOGlkCybGxuErz2yTUodzxuTmRj+dj6vGJsm4lFUlSuX090akvgWWgzgyKgWJt+Zoo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b2or7n9RlxmYql5wGJSqbCT/pBzM9wkTqCl0KohkFs=;
 b=sRm9wzTICcKiTvKVTJJD7Y/Cx6kcI2SZzKptSTs816r6Z0eFCqavLnWYKn5ZPY+zAHV2HbInyDyAT19mZVpPghATDmyF3GEjr45lJPE9FxPQsKbwaQf81kXxzfiQ2MvWRdwKQL8cXC8YI+B9PkLtfz46dzLj6xb0r+UKZlBVZeg8ZFdiWkpPPab1XxWiOO7tSV85rPI2xhcFCZy2TxF6MXa8TU0Kmf6pyuu9K91yKbrhsfMleXiQBKXvQ/+bUQgwvzh3ADtB3CU2ys7GZSjys0BE3nbvJG4xIS/+rduTuU2sqD06z11hMz3TtphHSzHCq2jNLlgPkJlYn/tlZynO+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10260.eurprd04.prod.outlook.com (2603:10a6:102:410::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:52:28 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:52:28 +0000
Message-ID: <f26faf51-dc73-4aa6-b519-3359b2a16a44@oss.nxp.com>
Date: Wed, 18 Mar 2026 13:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie
 <andra.ilie@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
 <20260318092215.23505-2-ciprianmarian.costea@oss.nxp.com>
 <20260318-unyielding-piquant-buzzard-ec69fb-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260318-unyielding-piquant-buzzard-ec69fb-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10260:EE_
X-MS-Office365-Filtering-Correlation-Id: 34893e2a-76da-429d-3a16-08de84e4d420
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QOszFBEwSyjG+oUy1ec53dJpMde6cTg6hjRzovgcXnDJfgc6hAsXrcAlor604sXHBlkMDVdfHZ6ptNj0Eyol30UoG4TSCzXVs2O8FQJldlrtySZ3HRM21rCPRx4nAMd9PXHMvkJMl+gR2kiqDHG91UGxkxq4NMDXIhSTGAAmsQ2FzBgIg1+TmKR1E+jxxmvbLaSo10rxFSVqs19duTtZfCkTmTBZewuf/IRQTdge1etDRLSf9LKSohOLRaF52ywOFfDg9k09BhW/T/KIdsFm4/IJalt7a3N4P4/LGrYH8E+no/elg7Is0+ZzBUkwIOk7ajcGgpgxYbVBgHLjQPxa8v8hYtL88r8PP/xTwfLXv0yCGYaGEQNRUNSoXMK5ZFarKhOVCRXm5LvghYaicEgbaoj97LygJZ77iDrBGuRJ75/W11W7D47kQlbRMBDfrDPIICsvF8G8MEQz1W3crRD3F4ldUY6j1vn4x+R4jEcuG1X+xsVMGf2rjekt0wO7Tn56x5XkjjlSmDKy2OWvY6VhZp5xKuVGgeQqc5mc+mX8QQ624dFFGfRJRjznflMuQeokr2kdoJzUexmmJDyRUz4xFTNum07E1Qosql6LrWe7F9yHA2FFSFcFuUyGlB4rESS0oJGW1mxW/K6FxHlHjuv9uI0hj5sF+pdCCve9ajG8lDk0jl5Tx1eY1EEKC5JD0Tti
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkowWk9IN0MzcmtrNTd5RGRnVG5JNWh0NTVTYW9BUHBVU1ZvZzk3dURMenR0?=
 =?utf-8?B?SmdxazFOb3Y1MXY4NnlncXBCWVJ1SzZ1ZzhwMHArNDVHTjF4WitVdWNoMDA5?=
 =?utf-8?B?VWpPdktTdUlzbTBMRVE4TWEyUjBnekdnemJkL08yWllQczF1aUVsZmRZYmRt?=
 =?utf-8?B?a3BOMWJST1BNKzBhaHJPbFBhbGtTbHBubnhxVEVsY0FIQVRxOWFFdWZJNXRq?=
 =?utf-8?B?WkZqSndMdHVlVUZJRERKb3Y4dGphYlV4bUtPSVpabDM2T29YZ2diTXV4eVNa?=
 =?utf-8?B?ZnZLbjJCM0NUNG8ySlBXZWdJVDUxc0RDVXJHRmJ1Sk9zWWM3RjIveHA4blRH?=
 =?utf-8?B?Q0xOMVBxR3oxbytlVWhKdmxQemN5SjFiYXlIeVgxRXphbTBwMU1vS0xiK01r?=
 =?utf-8?B?Zk5tbW9mSHhPYlhYZXdDeWU5UDhoVVh0TTIvdUVFRnBQcU41ZWp6cmd1R1B1?=
 =?utf-8?B?Tzg4dkhYSUdNNTlJUHpYMlVjMk9udGpaOTFVeXByaitQVUNFbXo5MkhSRlRB?=
 =?utf-8?B?R2dWb3lZNWN3cERBVGZzZ3haOUtsdnI3SXhaV1ZadldyQVl5d0phWGJmaFRl?=
 =?utf-8?B?TzcwOUxiUXNVSkNtOFU0ZmVoOGo4NVNjMExGdjhqcmxqOTBpY2FZaktzcVI5?=
 =?utf-8?B?aEdIdkg0VnRKUGlTdHF5N0Nlc2Z3Umt4VDhBTzZ5UVJJTjBZTGhXQVFpOURI?=
 =?utf-8?B?WmhDdnpYT2puYlJhWS8vTDhxR0xaUEZJTS9XcHFZQldSVnFSa3lHdkcrM3RT?=
 =?utf-8?B?NzRqc0g1M0kzNW5IOEd6czRLcHdpSGp6MGt3aU1mNWpUaERBNnJjMUo3OHR6?=
 =?utf-8?B?MHZhTEphRmtOK2swUlZyOE1vaUZNUFRhSzlOOU94anBrR1VTK0hFSHB5TjZM?=
 =?utf-8?B?cENyZ05uSWJ3cUdFam9yM2prNVlTalVmMkJHdXdwaERiclkxR29FR0RIMXds?=
 =?utf-8?B?ODB2UTBmRlRoTzRhTGlQQUxSS2ZNbWZPR1B5d3NiNFY2TVRRRnRhcWNxSmhM?=
 =?utf-8?B?VEFYV0pNUzZGcFZpZVp2eFZjeW9YQXhkTnA1a1J5eTZ2cWQzNDB5eVVuVHlt?=
 =?utf-8?B?bm85ZWZtYVA0TUZNekI0Qlc3N1FGdElUVkVIS1VnSHMrZEN6OFpzVUdVZG9G?=
 =?utf-8?B?VTZNakxsb1NQQVR3a3pVWm8xZEhpa01ZejNFdXBFbjR6bnAxVzhwbFFOWU9w?=
 =?utf-8?B?aG1mK3JjempQd3gzRWN5cEpIajIvQ2ZlUXhlSkdFdDAxS01wdUhJOFJMeFJU?=
 =?utf-8?B?YWFGU2tGcjFicUZsZWdLcDBTZUR3M2J2U0tWRXNXMkhCY2I0OVZzRThZZzEw?=
 =?utf-8?B?M2R0VDVjdUFrUDRRWDJOT002SThROTZOdnFsUWRDOGxKVnFVRFptQkNxM0JL?=
 =?utf-8?B?UHVpMVA2bFFCL3RiZ2QveDk5dnlHZEZvUG84bmkzQXpMcjFIUzJpMmdRN2Zy?=
 =?utf-8?B?L2dLK2p5UU1RaXpYOHNYTllEcTVLc3JjWTd0OXVxNUcrWkZaL08xWGM1WnZz?=
 =?utf-8?B?WnpvSGViUkU2RmJKMGhRMnc5MjJsd2RKYjkvdkdwWGh0aUtvajJtY3ZQSk52?=
 =?utf-8?B?MEFzZjRoNDBESGV3bW1ISTl1TlJSRzJjZ28rRDBRbTE0ZzFQVStXODhoVkIy?=
 =?utf-8?B?dVZmUFZNR2oxcEdiOWRjRk55dktwTFlRNmdZZXVPWmNBcWM5eW5MdVFaOVBU?=
 =?utf-8?B?aHVSWlM2d0ZDaUxPUlNRRDIyWkxVaSs4Qkpsc0xRa0czVUxLVDFBWm1taVJs?=
 =?utf-8?B?WnVyY1ZTTjBydlpWc3dJMm92eW5Pblk2NUxpV1RKSVU0Q1Yxcjc2MUprUGxH?=
 =?utf-8?B?Tkg3RUNKWjhNc1J6c1BkN3VhUVBQOWZmS25FWmtoaW1ITWpGUW9SamhuOE1y?=
 =?utf-8?B?OURIM1pZczZFMWxUN0ZGMjdOWVFVVWVUQUNTeWJqQ2dCRzFmVmo5NVhpNG9j?=
 =?utf-8?B?VXR4ZmU1WEFMcVlmVFl1MElxTXZQdHFydU9ya0tyUGNWMVJXMk83MFliQXpZ?=
 =?utf-8?B?V3l1ZHVhYTcvTmdtZ0lHekZWM2FFYnVEVmlJNXkwNVhNWnd4dTlMY204cUdn?=
 =?utf-8?B?MExyUE8vSlJkMVU0bzhkY1VLelAweWFRejBqRFZmY21EUTVLWXZGZE51TkhK?=
 =?utf-8?B?VG9kU1Q1bk5TSW4vcVNiSDBBVVJrUTZ5dlBna0ZJclE0ZlhqWkQ1M0tjWWFz?=
 =?utf-8?B?ZTgvS3dyWlhwNGlHeUoxVVhlRHhjVUR5U3M3ZGo4c3ZOYWI5RXdUamhFNVdu?=
 =?utf-8?B?Q2F2WEg0cWFpV0lMeHNsQVlNYjJ2ZzZTOEtMTmd5WDJtYTRRUng2VHUwWDF5?=
 =?utf-8?B?ekFtSk9iS2tmYlZldTduRmNkVFRlWnU3ZFhhbFNRSDR5VTIvLzVrL1ROM3NO?=
 =?utf-8?Q?VwA31sv1mPapsPj4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34893e2a-76da-429d-3a16-08de84e4d420
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:52:28.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2hEls/pG5C8Vlsq6IwWOy1XGghbpOCci7yfWs622ytNR/gCnJGvoQ2pcPZHbl+wdlxVNCJH5xOl2rw+rGB8A1sZL6qgKJEGByTB+GnkIsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10260
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7135-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:url,nxp.com:email]
X-Rspamd-Queue-Id: 390E42BB23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/2026 12:47 PM, Marc Kleine-Budde wrote:
> On 18.03.2026 10:22:11, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add NXP S32N79 SoC compatible string and interrupt properties.
>>
>> On S32N79, FlexCAN IP is integrated with two interrupt lines:
>> one for the mailbox interrupts (0-127) and one for signaling
>> errors and bus state changes.
> 

Hello Marc,

Thank you for your review.

Correct, I will update the commit message in V2 to clearly state the two 
different CAN concepts (bus error vs device state changes -- not bus 
state changes).

> Comment from patch#2 applies here, too:
> 
> Usually it's "bus error" and "state changes", as the errors happen
> visible for everyone on the bus, while the state change is local to the
> controller (every controller has it's own state).
> 
>> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> index f81d56f7c12a..131fae2739fa 100644
>> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - fsl,ls1021ar2-flexcan
>>             - fsl,lx2160ar1-flexcan
>>             - nxp,s32g2-flexcan
>> +          - nxp,s32n79-flexcan
>>         - items:
>>             - enum:
>>                 - fsl,imx53-flexcan
>> @@ -173,11 +174,38 @@ allOf:
>>               - const: mb-1
>>         required:
>>           - interrupt-names
>> -    else:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nxp,s32n79-flexcan
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          items:
>> +            - description: Message Buffer interrupt for mailboxes 0-127
>> +            - description: Bus Error interrupt
> 
> It's a combined Device state change and Bus Error detection interrupt?
> 

I will update the description in V2 to: 'Bus Error detection and Device
state change interrupt'.

>> +        interrupt-names:
>> +          items:
>> +            - const: mb-0
>> +            - const: berr
>> +      required:
>> +        - interrupt-names
>> +
>> +  - if:
>> +      not:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              enum:
>> +                - nxp,s32g2-flexcan
>> +                - nxp,s32n79-flexcan
> 
> Is there else if or something like that in YAML?
> 

AFAIK, dt-schema YAML doesn't have else if.
The negated if (not/contains/enum) seems to be the standard approach 
used elsewhere in the dt-bindings tree, e.g., in [1], [2], [3].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml#n70 

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml#n151
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml#n148

Best Regards,
Ciprian

>> +    then:
>>         properties:
>>           interrupts:
>>             maxItems: 1
>>           interrupt-names: false
>> +
>>     - if:
>>         required:
>>           - xceiver-supply
>> --
>> 2.43.0
>>
>>
>>
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


