Return-Path: <linux-can+bounces-7434-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMNIC50482mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7434-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202E4A1772
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56F473023079
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C9406269;
	Thu, 30 Apr 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AgQH6BQA"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8240244E;
	Thu, 30 Apr 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547235; cv=fail; b=mE7SCdbG0100sAnxm2dU6ZY2TXgjqReWG95KY9gCb0KQfvQsMbaeTc+Cp9SE7mdVHRlkNAIl12ieyiUlTR0wRp/sD4uM5+gdjyqKHzDiXImtjIXk3o4mxcKLJO0EYFwPlnVcAc/VSUy9UVdfT9AdYGwKV6lBC5r11PDvD3V5tlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547235; c=relaxed/simple;
	bh=Bre4YfNbUkeBbxvdF8OWh7PljAj1UFXqph/6ZpjLSqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYX6eGUkfPZuB4y5ssVflqNFI5ibd6KvM1t/Xfsg5PENQlY+QAg1qKhYEiH7hdNO4TMQDWtBoDSgxc0BvodTM2fF3ckkzKWVPCkXG5kHN39qNuWLPswwMvctkC6e6UF9oEqjOjXQ4+q42tvZFltM9923NrfL7mtH7qhRDNuWZwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AgQH6BQA; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO2mv1VY99QDz8LFSiDT6DqgHV+xx83EtMfasHfCqhimYzB75h/OspVvVzj6GDXy1jOHHGbfMaFBprHAOTkkMOGnmlr17vg1q5Hhfnl7Zmzk9AoS7MNuiqAS0wrmxjeF15ugEHC0IKg3UCHiRfZ2/Vius/0e/8iMh+XHk+SydGkgZKUSWyrr3pSby5zeB9bJYZJqdv1BRpw3GwaO79lekjt++Peenss+PN5f1Cc5EwSSvsGv6SN5nFvFC171qT28SvoofopAon9XRET1hwN82dsOofQ8PiyrC/Wgzi9yNyZicr6/s7YtCRQCsWifZ5Di9u7xTcaHiMK9GiybhGc+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BksTTm3Z/8WIj/u8E3VsRp1u6rwv8lKOq4Z69298DCs=;
 b=UOAqS8KhUWvMDNlYTyaHksWjx/o/XdHFuUvNW/hCIvGUxvi6m+9vptqwnUYIqJU+RGK9tXcMtjZT5PABoGmgAwb0GS1i8xHxg+JepslBXdQXrDsJ5a3L7FPXT4xyzNvY3HbjdruW6/7rfITpTxD4juAGsi2ZbNwkgUGhfDQHWXv9NNsS9IPEDN4m2S8bVt3+3cjFdZhQhil8539g0LWMMtoxHvUi7GLoDiiKoQHG0JtneRGfF0yHrn7eIPW71WUCzreG2ekdap0LU4SxJMx2nRF8BhQdhoJsWsXzR6UE3KpnLpRpkYERzkYWHm1Ot9MbtChpTfYbjMpxIE7FSoiYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BksTTm3Z/8WIj/u8E3VsRp1u6rwv8lKOq4Z69298DCs=;
 b=AgQH6BQAUWKGJWKdbNImFW8QLsTHOouNkPwu+chek2trzkaWlecRH4OnNFmLLSuDHUXz9keHikYZ7mR7oTnaajA1iDvlcNwlAo6KVuJD1UEQy8aIRVoStCyc0YQY947irt0ojHTxQdfZFeVcSskBjMXVKydgx4YYriQjVocM96Zd8GmPx7vgV06940MB3+L4mVL2plwZhg/n/GIevHei29rluKTfOJbBSuu0j4ttV9V4exwX/NF+DxpBAD3ykbbJexdXwJr0vuOSngpS2PSWlsaKXH2t5owA1m5jXp0czACmcemss5++5TVUbSKFiUiJdRaOlXVNUlfxXqsO47yV/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:04 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v7 phy-next 05/27] phy: add <linux/pm_runtime.h> where missing
Date: Thu, 30 Apr 2026 14:06:30 +0300
Message-Id: <20260430110652.558622-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e20b1b-29a1-4f9b-89cc-08dea6a89ca8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 OSXxN9u3a1XmB5epDi794iCNjteOWV6B24hL4qVPCQWI2xvnl+732lhhGOj3Nxx2uSOxHEj1JYWucMbdwmGYQv2kfNQoSKPkErLCAe6HgztaZc4CapFkfP5zy4giEVdXxKwa3KEEzY57Mm2YNm2Kev354m9w6/VyMhAqRaWv26w4ReCIFnY8jfWzMSkF9vkYXQLk+3oyxWauA01gh6kq2m5ar17D+xElAIWYGNkdCZe1O3+YrHvACOhUaKQlAhyzvMNN8P5pKj04kaXqUHI7G/rzDoh0IcQogGLC/T7o3folwpykKboZwkAJ4+ZlTqdbX1LgLr79gwYQopCJToXvBzg65jOR4KYArNpftgKFOB7ZtE8F09sHcB4HvXnFFCqQSlQFJO9kDxZjCJD7yA1ZAAoebnx3dK9FVBN7Gjeglmxb2VhvW/1sTeu+dz6JMjTGmK5kMb5qlq0YcINYMyQPRyZV/vzGLzKFwsUjHXKFockGEIZRfHdLL23fVM1jXU9haSlp6ANP1SFOyC06WTBZ2spwWNxOpuEKxzoPtcvUPwFowH5gyBbO0RQhyn4CgXdg9YesFI8TSyyiDbVkoJlgo7yoDyeJrS7h0vHVzUwJGcAqvyLUg6jGcL5HyCQ8W2LXLDnaS/gChJug1hJbz0YRPUGY5gJe23JBvI+7tkrsjf8rLG5OkHvXXRonNKX4AiRI7Mzjv20WbLuv6XIUPIlCwb34E3e9qzvZS7z9QgUT33E=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MEljS0xuT2RYQ2Qrdngrc2ZjcjByNlJLek1DODVXZjA2UlNGQ0EvT0dSZDll?=
 =?utf-8?B?Rjk2YkRXU3dJZlFUazI4NjA4dWcvYVM4Y1BMMmpCMWY3U3hpemYzNmIzdjhV?=
 =?utf-8?B?U1NobUticUpCQXd2Z1pyRlp0Mnh1VjQ3QVRoRXFrdmlsb1NYNlplcmtKczNY?=
 =?utf-8?B?NXFacTdoaFNEdU9kYVFZbzJvcFVjcUJsdnlMZ1k4dlRnYy9KYVFxYTQ0aXlu?=
 =?utf-8?B?N1BiWEUxa0NvK3UvWllVZnRMdkplQ29qUXcxeWNQelFvT0ZaVmJzdlpaejR4?=
 =?utf-8?B?VlBJMW5jNGNvVmt2Y0tlN0xsaXRuYmZQRWtXbGkwV2duZVFjZ1N0VjJCTHQx?=
 =?utf-8?B?bVZWNk1zSjFieDdvTC9lb3NrSWRFYVZQUmZsTUl1YXl6ekVOYXlsTW1xRlNm?=
 =?utf-8?B?Z1NtRUEzdVk1b3FmOGlBM0toMm1iNVlFQTZkQzlKNnpOWFlRRnYrTllqdmtM?=
 =?utf-8?B?RmR6clBxNTRmQ0Z1aUpmMTRnN3VHWCt1WmZjdkQwbTVySjU1d1Y5STNwNUdT?=
 =?utf-8?B?YjRNNHpxTjZUekEvNnNOcFU0QlhpYXl4b21BQStxZko1ckhuYTVFdHhSaHAv?=
 =?utf-8?B?NUlwWU9GdFlLMGVLTTE4OElPTEdCQ2VUU09ERDFGSmNSMk12Y1FnNHNKckZp?=
 =?utf-8?B?THI3SzhRQXk3UHZQRXNhWCtzeDMzdFVLQlpIeU1DdGF4ZFh1TnZFQjZCZHp6?=
 =?utf-8?B?Vkh0VVNBRVFETEFoV3A5b0lDSS9LNzk4ZGJCYWpQWmhsYWl5cHlCL21lc2dQ?=
 =?utf-8?B?ZU13NXJFd2V2T2I4aE9FSnBxS2RmdFlZWlF3K2hUNmsyYkEzL2pINGZoYWlu?=
 =?utf-8?B?QS9vRjl5ZjdTbmxEMlNDUkpvNXMwOGwvNnBEK2ptYVFWUWZqSll2RFZvd3VB?=
 =?utf-8?B?SkNzdnRwdVgvTVdYdWpES3BPNXNCaGJLYkRIbThBWmdITGNXTmw5TVB0cjdm?=
 =?utf-8?B?ZGVsQ25RNVdUc3RrQ0tOUXJuSEZTNGs2cEtMcmtvWEIvcDRmTXI1MVNKdjM5?=
 =?utf-8?B?QWs4SWhBSHhnbjFaVTJyYytlR0ozSnJ2WDNyaTJRSTBEUzlxeWFUMEkxY1hp?=
 =?utf-8?B?emdCMHNCdDllaGFYK29ESENwTGxxQmZGSjk2YzRRVTc4VUd6Rm1jK1R6TDRR?=
 =?utf-8?B?N1VvZ28vamhtQ3VmU2xRRkZtejE0UElFT3o1V1FSc0x3bFdrR2ptVy84emJ1?=
 =?utf-8?B?VkpVd0xQOHpLbDJTQ2wvZkl6OC9ka1RzR1lRdWU3MEVNdHY5SkVaWUVyNGhs?=
 =?utf-8?B?SFEwcGROeW0zWnlDMVJkRVRlSXdGRzhWc0pXSVRtc2RrMGNxeVZRNWFZbmlZ?=
 =?utf-8?B?YWptZWVEY2FRZUtBSi94aGJBeGU2UHA0N3ZobGl3c2ZJOXp1RW40TnkrT3BB?=
 =?utf-8?B?c3BwUjUxeEF5cmgxSTJ3TWVzNjhnODg1TnFIVlpKd3pJVDBUTzhiWHBDbU0w?=
 =?utf-8?B?bS9aNmJHL05oTldJYzgyTW5MTXpHYnZWUmZnVTZiN3RBS3hXdEwydkVILzl5?=
 =?utf-8?B?NllydGd0cW1SeTNJclMvYTc2YVEzRTJMTm10Zk8zQjc2UzZJZDhRN3JhdWdZ?=
 =?utf-8?B?ai9MZEEybWRQNFdBMzk3dVI2S0V1cmpJQWhQSjFrb2QwMmwxblNpZ3Y5c21j?=
 =?utf-8?B?bnYzQmlqYkZCZ0x1U2cyd2svS0pDcDZ4b1hDUmhIblYwSTBRY29jYkVXclZ1?=
 =?utf-8?B?c0UvRm5Wdld6RS9vVWFteXpVRGZra2RMUjc3TGdoaGU2bGo5WnFtVUJmcGYz?=
 =?utf-8?B?OWdnbS9wTFJ2T2Q5VThVdzJwYkVTV2djb1pqRFFsTk5FSE1yNTIvUGgyZzg5?=
 =?utf-8?B?UHJWNWwzK3VJdnhhUUgyZmY1c1grSW50cmE5RUNMelV2eUVIZHFnU0QwSHYw?=
 =?utf-8?B?V1NlM0dIc1NBb2M4OC9wS0J1NktwV1Y1Yy9NQkE4Q1VYTVBOTk03cFBzalJ2?=
 =?utf-8?B?VXJOUFpINXNPWmxsSUl5QTQ4bTlGVE85dWdmYVJ0YzB1TDA1WklUR2RGdGcv?=
 =?utf-8?B?cTcvY1VOVWtsRks0cFR4aGg0cDE2ZkxGeitYNVZUN1NmaTdUZFZCOUJZeFBQ?=
 =?utf-8?B?WGh3a3VOTHlkd3RCYlNWTGN4Rm9JMTdST0MwUjlEdzJoYmIyRmpDVFVseDla?=
 =?utf-8?B?ZUo2bVVZam1QMjR6Z0IxY3RLcHdVa1k1NkZON1MzOUo1MHlyZFFycUlRR2VK?=
 =?utf-8?B?MitVTVJ0MTE3MDRKM3lRcHZwN2RVRk4vL3lXMVhTd2lqTWI2UnNMcG9xZGpu?=
 =?utf-8?B?VTFuMmhnaGxNUEtMUkhCbnlnSlVXR1VpZjd0UEpFbG9nVXRabGhWM1lDUFFQ?=
 =?utf-8?B?SDMyV3c4dDJzanFCbWNKSXRnTkpaOW1uLzVsRXJDSzdRUUdtSWNWVGtudGk1?=
 =?utf-8?Q?nnPyhE5gya2cr/3vpCKEBHR0dhV/+k6n3to3r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e20b1b-29a1-4f9b-89cc-08dea6a89ca8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:04.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSjQrYp8ssvEfS0pKCkTmLEcTwWxWyQ3rw782VVCLZ/vRKQLw+ujhmtCbU5D4nJmeKat4kFrls1UsgXQM5XpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: 3202E4A1772
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7434-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,linaro.org:email,sntech.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:email]

It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
call runtime PM operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v2->v7: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.34.1


