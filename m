Return-Path: <linux-can+bounces-6944-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PXmFkV6qWl77wAAu9opvQ
	(envelope-from <linux-can+bounces-6944-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:42:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78F211E13
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A95B30BF3E8
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193F37C939;
	Thu,  5 Mar 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oUqlfobS"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC4248176;
	Thu,  5 Mar 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714333; cv=fail; b=WUpVmfJv61Zy3T+UlJzBARCcruCJCCqEU6/4S+hDEN1mh1rXLT4uEm7C9Q0RulEjye4DzAJqnQe0IiF8qx8lBi/vCLNF29XAoQfA6yvNWZy7/M6D2X82XC2MqIEE+at9YkTCRyeEJC+NkG5QglbQFcYQFUtzvUjflYLNoNRzV1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714333; c=relaxed/simple;
	bh=jtxBF6MniA97Rb+iLu6UVwBd+n8wZNHuhIWbJWFZAyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fqUdXV5cylPYsLYIx0HGWLxcD9anxWgwa3+75RaSDE6CrwGo970zSY4bmL/PoCu98k05ZKHaYiD2Cv7XECPu5gLfoMPyOLUn0lqwcCI7hI4srtO+0NbIGDadnQFuBqXW2rbgY4xRY/KJd9jVMpAsbly9RHsRFQ8iK7PXjQZuPS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oUqlfobS; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbJcrMZ8JoL3JM+UQarEIlYo1VRL76lF/yu1Ysk8dIbpKfIW+YQyuD30V7S7fZCpKeGcZ2QB4imDosCntYHiSndWmbdkWGQoAeX5pyCxtWaaBOo8KaxUjSmn9cfQ03VUh9PcwTm8XwvLGQxOZJ2ROoaKQik/B66rtHB/Ex17F+OkMtVxmUbX4xauqF785Jq9J5Gdrti22QySMG20h/+INnGnRNaUYn4rFbpZGd0A7GjBv1h1kNtTTcV3dmjA8l8+gtS0JIVkfkOw0f9SSppXU64jc/BuuLQZoRzWTYESeTW9lBLVpczMPttRpk5yRKo151xKzxiZOgjqPQRnHJRz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5zVsERJ5AxLSu+YZ8Q76HfpHYdfqT3jJxmwrqINGnM=;
 b=S+3ojnKwSNBnLejWohnje/QHQt9J34aMfJil+J11jjER2+ERCndiPBMI2QDZRXGKffgKnKnzGm0o5mlOjqE4U/T9x57d4czO/8jlZJOEjvJbL7wJ/XZU1gbX89NnP8j4JbnPisv4VVo4tRuJnT2/thEx5q2iblPw7cwOWuN3kKhjMmBhlgBVUY0ICdiyfTY6gRW/D3Zlj1uB8Jlw8+aCPpt5oZOipcceJeCLtzxxPuzb8Pmdzyamyqe/rEM4V7U+ggeZoDowibzvceSqBPLBPtvVBdif1GMFqXjVe+GUvtM0MPXxpag87M84gvVd+obBMXciBmkYtCUmFmUmTbK8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5zVsERJ5AxLSu+YZ8Q76HfpHYdfqT3jJxmwrqINGnM=;
 b=oUqlfobSt5WV1IwafvcYR4pbTs8L/SocsjZ5aY8Z3tvURLsOdwKeUHhxLCt714SsBDCTkPyPn0Pq5NxSBZiF/ka/I+GLrfBvpXkrEDmrMZPV48mK/91I3HjAr7tlXcBiUp+EWfg9QmkSmhfcLxhRG/2FAcuCD7kpRYWXpR/xXxiFrMXheV/jF8mhExU1s8R4hVRqMeO4BjzG+zxTXAgdrlZRm9JPddeJZHJqkfMeVHzQRS+EvEQsDT8T5dSNyaMBY+DE4tY4xYOcDyuKXhz7G9NC/JguHKGq/SxvEy66/gELa4FV8Z6eMg0WTYnePQ5KkDEaNwNII79+sHvaZ5SuUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10677.eurprd04.prod.outlook.com (2603:10a6:150:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:38:47 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 12:38:47 +0000
Date: Thu, 5 Mar 2026 14:38:43 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305123843.i47asdrjychwlgdt@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305121532.GA1649635@rocinante>
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10677:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fd34bf-a4bd-4ba1-ae20-08de7ab42580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	Or+3d3/Ai/ryZw9YiuleRyLi6cCpR/E4gqjC7S9WM3nwx9v938lMLYmfPt8wASXmJkcCeqES7dQP00CmXE8idAgy6SwSJQuomwP9SkcoRUzDj3VGHd6+co+pjwYpGoiA6g7R4WOzuAt8PpDZi4gBSnX5qeKlfNGHTxmHX8QiGOS1m682O2qX+Oz1cvy/IBLLMzZ7DfAIoLUX+4JWEOmIxCq5DY+f/BVhluUbA7KfccSnERH7SBttosd/r5zAsConSn/00qM1bycBYAwSMLFBkQCJicNM1IITNiE/OFgYEJw7IH/KXVSVkH9HW0fDmxFKUWphxIO4b6iR8vPQQalzRtU0H0oMkfjQpqfVjvlZc1FkBoaTnA35Qkf9GPpgF0au80lUL1ITwqoVIR6AsHNxqIyLXJDIE1NmBujwPS1Bi8eSzwPZomDu5S0uGL8ucs4Hiq23xFTlEeFUvoCdKgLWB4YzyGixa+pdjdAs6Wy+G8yJsAWyMn02/fL20iPpCr9orYFYKFYqG3Wykns+JGSD1KeVg7wHTYQnk3hHoUmyMijoH2Di8kCgIeEh792TtJuWELSd45qq5TxK8iBEROCG/tJKi5Hkk9zjnhrEc1j/nuzCKWSsa27cCCl7F2STkh4w4J8hz7kkjfpiwXVSkDoqCqn+cRjks05o50h/a1LZllRfW0QXjUVh3rcNSvZv8bvAjH5Z4OHj9HiPvvGl+6J5U59vroFPrWkPWHla1yrpjz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVRFZVpvdTRVSE1td2poSE5HdWRRZ2NwellsNmtKbmVvUnA5TjI0Q2JqV2Jt?=
 =?utf-8?B?K0FRSFhqZkdIdTJvSFhaR2FTQTFRQU5MM1R4UEorRUY5Zy9MM3NtT3ZJUWhH?=
 =?utf-8?B?dzdzRlBLUTNOZnozUlEvQ3FJVVBtVjFFRlJ2dkRoNHBZZTloNmFDcU80T3Fx?=
 =?utf-8?B?UWxXZGRrbis3STh4MnZlaGNaNyttQVVaNHlZenVqT2hjOWFFYnpRbnJldkpD?=
 =?utf-8?B?Z1dWV2o1SkEwM2JTTjJRUjVEUGdJUUVYRCt3WTR2TDRtNzZMc0tnQVExaStv?=
 =?utf-8?B?ZDFDQ1g2VHJMS2cwcDAzbmFXczBVV2d5QktTbDBNaFVZZHJSVlIyVjhjSW5P?=
 =?utf-8?B?R3p5T3k5b2p0MEpJMXozbm9NV05lRjduM1lwMys3b2kwOVRPMk9VbmliMUpO?=
 =?utf-8?B?UzJYUTV2Wk01alpYeXAydWxlMExRNnF2RGozY0JRQ0VwYnNhejMvRlRmeG1Q?=
 =?utf-8?B?Z3A5c1QzUnZCQVA5OVJrYU13a0Q2RVI5UmFtKzQxaXJBTWlJTG01blNUWkcw?=
 =?utf-8?B?WGxDam5CdFJYMHVEMDNlUFJHb3BucElBbTNyUkZpcEhXVUQxeVFZMzIrcUVM?=
 =?utf-8?B?b1E1Q3ByU0ZwbWowSkFReWovRzdPTEJ5dFM4Vng0QitTY0lyNGt6WGpzZktn?=
 =?utf-8?B?QzErcGRjU0RyTmhVY3E3TGJFQkxwUE13cmVaR1oxcTZ4WG10bGoxRzRodzM1?=
 =?utf-8?B?QmIyTk9PcnloZW9EendTblM1c3gyVTJqMnlyZVhPUzJPYmtTK2FDaTN1TE9W?=
 =?utf-8?B?SmhIWVhLTVphc0s4MUFTY09EUE93V1lQUjloQW43VDZSV2Z0OHRqQUVML2da?=
 =?utf-8?B?L05RR3pHTjE3V3JjMkc3RVphelVvOFRCTnZUSFlvQkcyaVZyMHhxRlhORjl3?=
 =?utf-8?B?U0ovN1hkL2tqWk96WDdjcndjazlaci82SnpyUmtsR0RzNjRIY2NHYXZnTkJK?=
 =?utf-8?B?VDNLVW9yRVQ1SWhRa3J1M01YVDNBT1N6a0VoN1NybTA4dVA4TG9XNEN4emxE?=
 =?utf-8?B?cGZCamVyUTJUdGhVZ3crb2hPdytzeXlmZVNqK2ZoSGpwTGxTNk1zWThXTStK?=
 =?utf-8?B?YkNrUmhvejVhRk8rUDZFZnQwL3JOSGJwOEpybTVkNkc4MlpQUEFhOXMyellv?=
 =?utf-8?B?bFNUNitkcGQzc2dGKzJkL2xtSS82SFQ5bjIyb2RtR0wzU0krbnUzSjFRK3E0?=
 =?utf-8?B?WTUxRGVPbE9sQ2tmY2h6a2RPaU42N1RKa1dqT1k4M1p6Y3Z1YmJPc3FXSTFX?=
 =?utf-8?B?QjFDYURkM2hzYytWdXVlYnMwdGk3cnhWYThud1BONXpMZDRwL1BKMEFoR2FW?=
 =?utf-8?B?bUhaVWNIQXZzN3h0T2lyYnpuMGIvcS9LcWliSzU3K2RTY01DL1ZxOXhHTEpV?=
 =?utf-8?B?T2s2Um4xL3pDMEFsUC9zVDNTVXNBeGpScjFrN2JueXJyVTY0c2VtRTY2ZmJx?=
 =?utf-8?B?Q0NvdkpWVWprL2s1ajNpcSsrSkdXN1V3Njd3RHZuNFNWbElqL3Z1M2ZTdjVy?=
 =?utf-8?B?OW1wSDhkc0hTUjlRZVNaVzlNTVdmOUsrbmhOT2h6UnNvZ1pEQTBncnZ0ZEVj?=
 =?utf-8?B?OWRYcU5OS29NelZwZ1RrWnRlZXNGSS9sZEU5V3FuUXJMVWNFRlZobTZiTS9v?=
 =?utf-8?B?WEdzN1lmK2ZRRU9nMHZOaVl6dkRHMjB4amN2YysvVlJRNUNvVVZPa1NVRXJr?=
 =?utf-8?B?ZWc3NzNYdm15K0N0YkdOeUllMVd4UGhNcU5VVGovRlFlbVdwTDE1YkF0Y3Z6?=
 =?utf-8?B?SHp6UWJ0Yy81K3V2U2FMQ0UydUVzMEltN3B4bmJPUkN1Z3h0QWtnVHFLcWNn?=
 =?utf-8?B?REFJZS8zeDlMRUhNdnQvM2FMeGc1NUxibXNJUlpIWVYwVG9URTlBZ09NRWRP?=
 =?utf-8?B?RW4vRHlCalg0djBla01TYzNUc1NiNFN4blFPcmlzbjJaclJjNklibUlva0ln?=
 =?utf-8?B?ZHl3OHdFbDJPakkrK3ZQdTZjbWdsZXJ5bGFyaThuMDlCMEpWUGszdGlwWDZv?=
 =?utf-8?B?WE1EbUdLdGlOdjlyNnpCRUtBMkt2cFBDNW5kdDJEc3J5ektsRzdydVd6OFVk?=
 =?utf-8?B?bWcxemFYWDBYWm1KNUZueHdNenVBT0ZFMUtScjhzZ2RuSFlLeGlBOFNGK1F0?=
 =?utf-8?B?KzA5cjArTXFkdlVrNXZReXVWWU5sS0ZONnFDYmMvdWY2ZmE4S0FSbkdmdjNV?=
 =?utf-8?B?ckU2TG9FYkUzRUV2YWtFT2N4aGZTRk9qUlBRcnZhaDVOWTMxNFloelBIRUl1?=
 =?utf-8?B?MytZUlFsdmxaS2JFZDZDajFzV3c3QS9mRys5cWJBaEMxNDRhRU9HZS9xN0J2?=
 =?utf-8?B?TmRFTTRkRFJZaTE0aGpYZGplSHhvNSsvR3hjelIrVFN0QjdNMWVaNCtuVyty?=
 =?utf-8?Q?VSQ4n96COp+VeG6DZUIqCWVnYJeZC0fJ6wvBjGTbu27n2?=
X-MS-Exchange-AntiSpam-MessageData-1: icg1hWaeECYBMzVpOHpoBY6XIi2hkmJbrlQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd34bf-a4bd-4ba1-ae20-08de7ab42580
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:38:47.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgDM6NP8bMhDa1quO7mroDtw6ECkhySH2qEHvkhMYT1b5RojcHOyLsIjjwaiPJT1OvIxWKhpdZSLVTruGzsBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10677
X-Rspamd-Queue-Id: 1C78F211E13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6944-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,qt2025.rs:url,ax88796b_rust.rs:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:15:32PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > K:    \b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> > K:    \bphy_(?:create|remove)_lookup\b
> > K:    \bphy_(?:get|set)?_drvdata\b
> > K:    \b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> > K:    \bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> > K:    \bphy_(?:init|exit|power_(?:on|off))\b
> > K:    \bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> > K:    \bphy_(?:reset|configure|validate|calibrate)\b
> > K:    \bphy_notify_(?:connect|disconnect|state)\b
> > K:    (?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> > K:    (?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)
> 
> What about
> 
>   F:    drivers/*/*phy*
> 
> or something along these lines.
> 
>         Krzysztof

I don't understand your suggestion. Is it meant as a replacement for the
keyword regexes? Your file pattern matches on:

$ ls drivers/*/*phy*
drivers/base/physical_location.c           drivers/phy/phy-airoha-pcie.c        drivers/phy/phy-core-mipi-dphy.c   drivers/phy/phy-snps-eusb2.c
drivers/base/physical_location.h           drivers/phy/phy-airoha-pcie-regs.h   drivers/phy/phy-google-usb.c       drivers/phy/phy-spacemit-k1-pcie.c
drivers/firewire/phy-packet-definitions.h  drivers/phy/phy-can-transceiver.c    drivers/phy/phy-lgm-usb.c          drivers/phy/phy-xgene.c
drivers/net/sungem_phy.c                   drivers/phy/phy-common-props.c       drivers/phy/phy-lpc18xx-usb-otg.c  drivers/reset/reset-rzg2l-usbphy-ctrl.c
drivers/nfc/mei_phy.c                      drivers/phy/phy-common-props-test.c  drivers/phy/phy-nxp-ptn3222.c      drivers/reset/reset-rzv2h-usb2phy.c
drivers/nfc/mei_phy.h                      drivers/phy/phy-core.c               drivers/phy/phy-pistachio-usb.c

drivers/net/phy:
adin1100.c        bcm87xx.c      dp83848.c     lxt.c                 mediatek             mxl-gpy.c                 phy_caps.c           qsemi.c     teranetics.c
adin.c            bcm-cygnus.c   dp83867.c     Makefile              meson-gxl.c          national.c                phy-caps.h           qt2025.rs   uPD60620.c
air_en8811h.c     bcm-phy-lib.c  dp83869.c     marvell10g.c          micrel.c             ncn26000.c                phy-core.c           realtek     vitesse.c
amd.c             bcm-phy-lib.h  dp83tc811.c   marvell-88q2xxx.c     microchip.c          nxp-c45-tja11xx.c         phy_device.c         rockchip.c  xilinx_gmii2rgmii.c
aquantia          bcm-phy-ptp.c  dp83td510.c   marvell-88x2222.c     microchip_rds_ptp.c  nxp-c45-tja11xx.h         phy_led_triggers.c   sfp-bus.c
as21xxx.c         broadcom.c     dp83tg720.c   marvell.c             microchip_rds_ptp.h  nxp-c45-tja11xx-macsec.c  phylib.h             sfp.c
ax88796b.c        cicada.c       et1011c.c     mdio_bus.c            microchip_t1.c       nxp-cbtx.c                phylib-internal.h    sfp.h
ax88796b_rust.rs  cortina.c      fixed_phy.c   mdio_bus_provider.c   microchip_t1s.c      nxp-tja11xx.c             phylink.c            smsc.c
bcm54140.c        davicom.c      icplus.c      mdio_device.c         mii_timestamper.c    open_alliance_helpers.c   phy_link_topology.c  ste10Xp.c
bcm63xx.c         dp83640.c      intel-xway.c  mdio_devres.c         motorcomm.c          open_alliance_helpers.h   phy_package.c        stubs.c
bcm7xxx.c         dp83640_reg.h  Kconfig       mdio-open-alliance.h  mscc                 phy.c                     phy_port.c           swphy.c
bcm84881.c        dp83822.c      linkmode.c    mdio-private.h        mxl-86110.c          phy-c45.c                 qcom                 swphy.h

drivers/usb/phy:
Kconfig   phy-ab8500-usb.c      phy-am335x-control.h  phy-fsl-usb.h  phy-gpio-vbus-usb.c  phy-mv-usb.h    phy-tahvo.c        phy-ulpi.c
Makefile  phy-am335x.c          phy.c                 phy-generic.c  phy-isp1301.c        phy-mxs-usb.c   phy-tegra-usb.c    phy-ulpi-viewport.c
of.c      phy-am335x-control.c  phy-fsl-usb.c         phy-generic.h  phy-keystone.c       phy-omap-otg.c  phy-twl6030-usb.c

There are a lot of false positives, and a lot of false negatives.

