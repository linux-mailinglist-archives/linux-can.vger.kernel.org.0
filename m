Return-Path: <linux-can+bounces-2216-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3A9D8A58
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 17:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE92285F3A
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCDA1B4137;
	Mon, 25 Nov 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GhEkvq0Q"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4D1ADFFE;
	Mon, 25 Nov 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552275; cv=fail; b=jUbouuAd+gh44AquP9dGFS89BUIL/r54HmwtRBQtEDmR4shb/q0XokqetpZl3CR97hE2FvBFNAjq0guwHFIhXF2ThnStquPChNWCObH8sdLCZ1EFVbSiQ0Oiv38jvk/qYzGeG4yH7JDuDJ/xy/R+XLkl1DWTV9L5pF9vCMbxUdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552275; c=relaxed/simple;
	bh=c0k4FYvVY4v+5y7Iq7ZBBDo2axLBDSItp9z1HrgGjiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYMT624gTcuEFb+KmKBo4Xf1pM2O8S7Y3CdhsyRQqEXc7BnhdBVXpdKs4ecWURSJTIG5NInsVDJbsGXgk9xpr+y+ePax72fuBEJtnlhRE4kNmA6591FU+BIMwIGo4z+X2DIOoxXwi726Om+y/VYE8TH634PzB6Be+c3kP5V6QDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GhEkvq0Q; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHa7aCoKzOXJ2EKHGjpZg3LgY6cNp/2XUQLCD4kkN/jIVYFwZk8RCI70Ye9O90tbdBFM//EyykhEpynY9PL4xjc3HphVgFEeCLzrdELssG8DegzjPllKp24pWkAmDIJjazAhiBuhjbf0ojDMl3ZkES6lyrFV+kWdAVzfC96OtJTzdC3fGCI8O6MO4HYt2k5jQLlui9BEB6BbjmgJS23G1cwGfRkmS0YdaqkdkZ1LF016vlYAzqIV50KzV2xyXUVVQYbx74zTzFXVWyTDe0aV7ZzUNteSvGURngMiHzphwuEYFpEUnj/M5p/IZWijS+fjJ3K050+ueMXkS4zLLmEWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztwf2KhTGUGv8g1NelpBfusYCgEfso53m9HKNyyM6kM=;
 b=hf7EVm1pB5vo06D0uJeeFLLlONNQBB0NQeyuEmxmO464TabLiWHy2+Fu7VWEEYeqnLARdZsXok9mDNuyMZwqwvw6H8XB5DfO0OQVGwUkZJz/R7Amp+tEndBM4COyJVIi74zcIOCl3XH+srtZGB5YxiOLT193Ca4o9rzwFD6W/8edghBVpdB6z1FacVHmIWTpiexPV+hYYrXByMhVRIrt0E7A+k3Kc/EEoy0BEndbOpyrmZWXN1q6o/o0HBphZ71wSjMHJROGJITUxST+QxzXAZNhSvIWVOHE2euOMG5fInb2ysVi4KSOiPM2P0nY3+auM8d4geKoWyKJRt9KtA00Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztwf2KhTGUGv8g1NelpBfusYCgEfso53m9HKNyyM6kM=;
 b=GhEkvq0QWqcIMZWS0R4n3eNTF2FOXbPfznvh3M7GpVASyRZXo5BCF013qjVKKl3+CQF3mr0ahAkc9Dz2W2VSzvqEY+atKPCkRtZb0T2mOa2h926bqc2zzwNROjTicxmyJcwkAUiRivPXOEDmgllJyQCLnhd/1IodCFI31wl3iw2sLVqZ8+XsKv28XAf9n9GkeerKuR4rNkUzJkeqKhCjIctPgq3TyD5BDjrJO8lKkspCVEvWiLpInzxE6p7iArTmPc64uqZO/Un3D1n09A9V1d2/a0TM745qdZe6k5Ve1NfMhD8Ftoyqh2B1hw+8RDPjiy65QLgNDPeyu+ISwcNxgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 16:31:07 +0000
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb]) by AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:31:07 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 0/3] add FlexCAN support for S32G2/S32G3 SoCs
Date: Mon, 25 Nov 2024 18:30:59 +0200
Message-ID: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::13) To AS1PR04MB9261.eurprd04.prod.outlook.com
 (2603:10a6:20b:4c7::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9261:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea61d12-3e70-41b3-e91b-08dd0d6e8fe3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFR2aG0wNnlkSnlyQWc4dXo1ZXRkUGYrdTlycjh4cFpGN0paVDNNakZzK1dS?=
 =?utf-8?B?MVh5S05qeENwcFJPMFpCRzc5QStCRUNZN2VzNmN0Um9oYjBRcHYvZ2wwYlM2?=
 =?utf-8?B?YTBWTjZlak50OWZKTkRiUFZUeWplYlY5WVVTalFGVThXK1BEWjZJNkdCNjkw?=
 =?utf-8?B?eklaNzRHSEUyb3FsT2dwOHRySTNOem1FQkk4VTFZT1dYNWdTNjg0VVFBSVZG?=
 =?utf-8?B?ODJIZHpLUGwvc1VsejJST08vZC9pSnRMeU4vVmVpaW1McFFtemQxMEpzREJ1?=
 =?utf-8?B?WFVXU08rWVgyWXVwVnRhcXozUklReEtjdmZhNHNWbWx1RUsvQ3JISml0K1BJ?=
 =?utf-8?B?bGphZ3dxOVRSd1lNMWhtTEI1WGNzVTF5QWExaFlraXJYa25GSkJwRzNJMkh6?=
 =?utf-8?B?L3ZjdFBqMmtLSG11RjQ3cEJ0NE9iV0cxK1BKeGlrK3Jha0p6RGxuQlBPMmV0?=
 =?utf-8?B?bHkzYmNhVkZyWjBRRWljQ0tURVhTdmpsbkNJMmVEUXNnc21hNll5UzdoTXkv?=
 =?utf-8?B?M3hiYzkyekFXYmdrd1A3YUxCMnVSOFV5WFlkUEI2WG9HRCtQZms4OExUUENB?=
 =?utf-8?B?cnYrYWlIZ2gzc2JESEI2enpCVVNEQmdmK0hJMkpNZHQyMjQ1WEhBbnQwSDZ2?=
 =?utf-8?B?ZGM1OFk5QUdySnVwT29pSGZDeFhOcTluMXFDV2Zycm5ZbUNqM01mekJ0OXZC?=
 =?utf-8?B?YzR1N2VURktWSkt5cGVqSFVuNWdQMHdlOXNhQ0NNK2p4V1JmQlFDaUJkdmR0?=
 =?utf-8?B?YldOSURwVU11Q3E1a1lQcnBOUk9pVlQzbWs0SlNxSTRaYXRuK2FkWXZGN1hk?=
 =?utf-8?B?TUtsR3FlN0hBUVU4UTBiV0dHSjZQckJoRlNJRG9WdTNrZXZqVUtjRVBDanp3?=
 =?utf-8?B?czFUcFNuYllUOHpoTHBJNTNoY2MvdEJMbHpRa2dwSk5WRVp4L3d3cWUrTXg4?=
 =?utf-8?B?WDRuRzc2RnYxQWkrUytPZHhpTG5xRExsZlhEZFltWXpkUVcrOHZwd3FtR3gy?=
 =?utf-8?B?MG5FZjQvUW9RLzBVbVgvdG84RTJacGlKWFcwUEQrQjFwMlpaeUhXUGgzQmkz?=
 =?utf-8?B?dGQ4RkF5K0FWeEVIVnhnMHZpTVJ3TkFVNk1kUms4TXZRZy9XTE1Sd2owcHpt?=
 =?utf-8?B?cWMxcTN4ZVEzUGlXY0lGL3k3TlRkV0IvaFZLYWpiRnlNc1hXWFJYOEVPTDkz?=
 =?utf-8?B?K2FxdVAxZXN2TnhRUkF3VTNtZS83WVB0QTVHMC9BT09vMk5vTWE3UE9WRkdZ?=
 =?utf-8?B?ZVRwOGZTME83TlA4RE1yS2o2cUdlZ3c0RldIbUtWb1BrbVVwZVFYSytiVkxo?=
 =?utf-8?B?ZmVBMng4TWY5TE9RNkFkcjU1TDc4TmdCTFFDVS9CL0M1RW9POE9wRW9kejBR?=
 =?utf-8?B?K0IwUlE2TlBCNW9uWjlzNGJrNXdaU0lKSmRXOGFDdEJjbzgrY3N6YnpYWmtH?=
 =?utf-8?B?WGpnT1lWRFduUitneXE5YlhQSWZuQ1pqYVlzWG9ZaURHeTFYNHozUG9Ya1Aw?=
 =?utf-8?B?V2wvVVVOa1pnbHJ5REtNRi9xbkE1amduN3hHYjFCNTRpWkJ4dHNHK3R1Y2VT?=
 =?utf-8?B?M1BTdG1IcHIyanFFd2FDeWRHWjNNOVI0UExSeWdEbTRyc2JIZE5YcHF3bVNK?=
 =?utf-8?B?QTdnYmtxU0lhZ1RBQXdXWTZaV1h6NWIwbTIxMXRMNUJzSEs0MEtGaXFyNzZM?=
 =?utf-8?B?blJJUDVsREszSVlqN0JrM2x0Uzdkand4OU41cFpDTGd4VkFDZXZIaE80OThF?=
 =?utf-8?B?eXhVSU1uekE4ZTVyS05zUHgwVTJBQklKcnV0aWNya0E4Yyt6ZWhkb1hqVXJH?=
 =?utf-8?B?RFBCWkhTaXpUYlNpUEtrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9261.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2JsMHFvTkg0U3AwZ2UzcmFiem1Sb0N4MTdDanVuWkFjeHN4THIyb3luRndF?=
 =?utf-8?B?V0dDZklRN1NKb2FMWHAyeHczblg4bmZKdTFvRVhjam9nTUtneU5jeWVxWXNu?=
 =?utf-8?B?M3A4RHpaTzJoZXJJR0dnc255M2VabjJWYTQyUC9LNk1lVFpwOWxkL1E2K0dl?=
 =?utf-8?B?RHV2OWNhTml3RkV2OEZYVm5zVi9uanRLRGh0THRqVFBIaDVQN0lTdjl1L3Ux?=
 =?utf-8?B?YmluRFc1WVJDcEt6elZ4Z3pRT1kvM3g1TDAzekVXblo1azRqVm8rcDdLVVpx?=
 =?utf-8?B?VzdwdFNmVnh0NFlDaVJVQUFIcFBKWk81Nk1RZHRxaVZaNzZ1YzA5VzBJVExs?=
 =?utf-8?B?emZ6NitkZjNMT1l2Q3JyQ3dvcG5keWQ3VTNBUzB3Y2tjQVgySFd3Ny80UU9N?=
 =?utf-8?B?THRiUC9NMjJucDJoZXkxcCtpVU53V0dVVVRtTFByVlQzUjIvYlFMNGJZM0N0?=
 =?utf-8?B?c3JMQ0w1c2xVbFFSUUM4K2hTRWNHZEtUUnpEcDZKRVpGdzB1cGJ1QUtSQlpt?=
 =?utf-8?B?aHA2bStZbVlPTVZDb29NdlBQSHdsYXlyRGpJWG1Gb3R2cFJTdDkwWnJaa3lz?=
 =?utf-8?B?M1pPMURNZWJhZndKak9kRlIvZ202NjBsZVpXWGVDQlU2bmpxS1F4UllOWGZ4?=
 =?utf-8?B?cm5uUkZGK3Fwd01tZ0o5dm8vMjJVR09pQXppaXA1Q1gyQkw5THZWd3RKK1lu?=
 =?utf-8?B?YUoyNnZEZXZid2ttMjdiTnBrUW5nYU9NV2I1eFhYaHFpR1JTRmx5K3p6N3Zw?=
 =?utf-8?B?S0QwUE5nc2ZteWJsOUtHM0srUXFhMGhTckthYUIxMGNVWnVBWFFQV21rWVE3?=
 =?utf-8?B?dVNjU0ZJZjR5Ym04TVNtTmR1UmxqMG1objloZzEwa1VET1hEREJxT1BDRVRN?=
 =?utf-8?B?eFB3QytvRjlVckpJcXgrT25sTytwanJleDZsekxYei9BaHVOSnJ1eDczdFNT?=
 =?utf-8?B?UFZzVS8zRi95SUd4ekdwU29DTVNNZGVueGxncVFWU1NYYWNuRUpvS1VrSzZC?=
 =?utf-8?B?UlRvN2xjTy9wUWlGMDNnV1RYOUVETDFwMU1RZDh2MUE4aVYzekNMc2tjQ05x?=
 =?utf-8?B?V2toaVhWLzFFd25iTnlPcnpxR2V6VG42ZkE4MjJqQU1lWithOVlkemxWRVdL?=
 =?utf-8?B?UzI3ek5KOC9pNHpPekkzSHlmSi9VQU5qaVc0TXdKSHhhNE5wMjBXNUl2SFFY?=
 =?utf-8?B?N0VhQmtuVWZDSXJqWXhlSXJTS1h3b1BOV3p4TGhHdHc4eEdiSmJkL05Za3Nn?=
 =?utf-8?B?MTZqWmxwMnJOSWdXdHV3NTZPMzJxRGlxeFVCZngxQkhybmJVeWIwZGlqZ0ZX?=
 =?utf-8?B?dUJHYmtOQjFERjlscTAra3B6Y1dQS25sSDBjWjJkL09GeTd5TUpFUElDem5s?=
 =?utf-8?B?a3h5cTJiNjRUNEVqNXJSalZWZ1daZ2hZMHhNdnFmYzMyVGluQUtvbGxhdGFt?=
 =?utf-8?B?N1RMUlJHc291Z1phUVFLN240NkdhZGZCRnJjWHZPa2liK1Z6VHZaLzEwS09y?=
 =?utf-8?B?UmVFemgyaVpzQUs5aGtMcWh3ejExMUxVdFptL1VYb1B5NVZqVkxmL3M1eEND?=
 =?utf-8?B?aEt0cFFQTzRacVhIdVVNQnNNQjN2bFd5QjdxNzN1L3d4YnRwZUNDb2liR2V3?=
 =?utf-8?B?bnhhYUZaUmdMRVRzSUZBNEhsRlVFdzNEcGptS091aHJPcGxQSUxmc1RqdEla?=
 =?utf-8?B?ekYvYlBzbklwMVNuZnJlOXhCbXpTbVNoeHF5OElUVG1BcTRpL3hySjZkMmJU?=
 =?utf-8?B?ejROakRWaklPOGNxRFpwR1o1ZWN0ODBQWlVzdkJKQVJGblQ0ZXJ2bVprSlFs?=
 =?utf-8?B?UWQzZkw3V3hIRkdXd3FpVDNZQjN1ZnJWWU1iQ3UwOFkrQW9Vc2xUa3l3dnhx?=
 =?utf-8?B?WGcwSTBKNXRqeisrdVQzVDBkY21XTDkra2d0T3dlWEpMekl1V0M4UTZJYjJG?=
 =?utf-8?B?TjRvSSt5Qi9EQ0twSkhJOHcrajErVERzdFh1QUU3cEZ4YUFSZ3pkckU2ME1F?=
 =?utf-8?B?dEJycEh3NjNhZWVPQnlDQVJQYm0zODkwcFBTVkF0a3pFOXZTN2I5N0JoRmxC?=
 =?utf-8?B?aXlwUGJLZHZrczZXRlh0UHZPRlB0K3JzZUlBZUNKOFJBVnpzMVZtVDExNEdD?=
 =?utf-8?B?Y0tBVUdhRnRlRzhDNnBVV2xDdG52cm5GNXhEaitsajg1UHlORzM3UmZTTEhO?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea61d12-3e70-41b3-e91b-08dd0d6e8fe3
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9261.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:31:07.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQKMD948Sv8QI6AOga7Qx9L1DFq8F5/6LtVO8g+v4QQ4JhjODc+N2ZeTPMquLMCq779714zmURbOPz+CKY2tVgIwHVQ+RmVZRy3kAm8GKJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
hardware integration particularities.

Main difference covered by this patchset relates to interrupt management.
On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, MBs 0-7 and MBs 8-127 respectively.

Changes in V2:
- Separated 'FLEXCAN_QUIRK_NR_IRQ_3' quirk addition from S32G SoC Flexcan
  support.
- Provided more information in dt-bindings documentation with respect to
  FlexCAN module integration on S32G SoCs.
- Fixed and irq resource freeing management issue.

Ciprian Marian Costea (3):
  dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
  can: flexcan: Add quirk to handle separate interrupt lines for
    mailboxes
  can: flexcan: add NXP S32G2/S32G3 SoC support

 .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        | 35 +++++++++++++-
 drivers/net/can/flexcan/flexcan.h             |  5 ++
 3 files changed, 81 insertions(+), 5 deletions(-)

-- 
2.45.2


