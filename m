Return-Path: <linux-can+bounces-7459-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMWFJu1V82mLzgEAu9opvQ
	(envelope-from <linux-can+bounces-7459-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 15:15:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE14A349F
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 15:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18403301F481
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727884218BA;
	Thu, 30 Apr 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ha51BWrG"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020D3BED31;
	Thu, 30 Apr 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554855; cv=fail; b=Gbgl2e6PczPPpE4Tt4TkEQcUjXkgBzf/ya9Sr5ByGrz41/HnlCLCO9Y+HdfMyHV/qRL0ArRbcmOt6vRiwcv+/bnzZMZeZdHEVHjzxWdAnkqe3PxdJKPKlfCd5cOLwJcEO3TG94Eiopu31ga/tV/KfcncU8idzDo58DRtzd0qpMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554855; c=relaxed/simple;
	bh=AH1A5skINbAs8sroMIR+LWPYDhJVTblL2ruVJDBMxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bXujIYbrVxY5+v8N4SGHFLodhVv9pr8CdA6gwTpKYAZ/tczt9IQZVxEP3KlmQy2K0hGf4uFaQ9waYS0UkSY9h2Vd+Q6iNwNKWxRA2EESCYla8tz8WsvcUVQA4dxZTkjJ+SDtd4onunfLRyFA/UKuTOZINUJvV6PRuBmZLBX5fm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ha51BWrG; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLhdMTISKU7PRkyW6hdPNgraN2Gz2+t3bhE3Ps34yTmK9Nm6NM/dxtRJvJo7VCxLaI5iLTKeUTaBg/Fxg68rA90LWmnUqmqmSpNrU9/sm1A7PlJ3AndOXyWK1t3lmQenF0CHIWUhIODEOJFJwg93AOO2sCsveNz/zC5lNr1mNccxcONnH4MEKt1G3+nCzNwX5bEEUqcboCLDSQrluk10V3iNieFG6AU2GsjCIl0vw6mDaq5klyPRDlpVBBCDulX6fqZvd2mGzkSGmz+0wNiyrHfSmIRuMO+97rHCOAFY3Yu7mR0rMEEQEEdKJuZo5mbWmi4qPiwTk/sBh3syBQRwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir7o8M6GivbIaDlTA/aJPIPbDzPTKaLGkUcXrqV20XE=;
 b=fMsk6UqnihgPu2FEwiIfF78nXhPaea+aBLVr6NBSWCoywUHgtSAjwHhOdREGYjn834qtf2HQmsnMjdVjE/fR3QkMnepM2SbrBLKBYsMA45gOkU+WEZW6ADguCB40kjnl2xR3HM+9k6F2cDMriOZdu4kGTrAUuMW2UHvT88bo26Qr5SmAeteW2XQWiZ9rMTrl9oe6+1LLQr9arlx5C/txzI+Mu5BpOIoIjCAxw7jWOgonQDlGy+21khlVK5lJyVcrVZkwzDsnkGmXZdisxV6PhnoMJ51+mS8K1fViOauQjerXAST1TC5coDPrEW6kg0nXXwvfNH7ayUFbqn/lqdPMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir7o8M6GivbIaDlTA/aJPIPbDzPTKaLGkUcXrqV20XE=;
 b=Ha51BWrGR4kddN0/cHpg4c3jCRBqMMkMLyJcc5ePTRMy1tuxgodL0rl8b1oBjAcAH+yiUwez4P15vCpDkiBTNFjlu1qy6/omHWyORiGyX6ECZuEwS6PvMEPJp3tvjcY5l+9yffrO52IL99wPk2lnarnIZwbnD3po3F9czkjexl+adXAlmGt0DucJr3TpGttDhOM0Zre4X2IppJRYEkKOnXCwkyx3ve70X6YLG4OxK4hmON1Pb5eaLfMqkasaL3pl3i24ibgz0XfYQrB9Cj90SbwGs00eS1/mXLkp3EFpbMWnVHK9OYaCdyhpvbfBXid5hcfqqnoPOzKDVTmNz3w6Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:14:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 13:14:08 +0000
Date: Thu, 30 Apr 2026 16:14:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
 helper for consumers
Message-ID: <20260430131403.2elptecuozimo76s@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-18-vladimir.oltean@nxp.com>
 <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0251.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 30868a1a-e1ac-4785-a287-08dea6ba5ca6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|19092799006|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 zG4OVrLhrR2CtNxfHJ+fxxLlwDVlo1AU9V0vSMrDQg5bpwrhVd/yPdZ3GTlbTCldqDLGgClISrdkibbiRwYW7/VxQHqV+KxY2m043uwPU9fSaBbar+ZxNl14hUH/033+zaDU1WABuyomn7zqljYvcccXo6zzY6F+3gQvCmD0XTI5CUNsn5OLh0T8xK40rfo1/Lf9p9bxU7cqzdDjVB0OvZVnPA0t/j16J8tn8zCvOEfFTHkEmMGg4kYdGQTePTGYczjsygdioNretm0IcKDN3GA/kfuCLP274g9Iy50Srhhke6z/JOqL58fitmGGDqTt6th5u60u6dXsb6Uj7WNfmzSnAlnCm5xp6mzmcOO2Xz4GNzx6Y5YsNphv3DpdgmQ4CTciQlYr33lUG7K/QlPbZOApzWu8dSvD5eKv0SZuU7ryto9aYJ+UJhGg55KiQ6b1Z6/iETwBoeJ1XU1UC0EGFv79HSSZEF1Czspy44c3CPJAmifSioc6xUmFYgEx8pgqJHkUMMQTbZxExl1xYc5F2dAf+ehSFS11W1zxo7OBLdCbzYeKh0Ez077DOieFnv0qH4dSvTGUR4qT3Eqafz/BhMFRNLR93afpj9yq4xbKvrtTjzEUzLQ95wp6wEAHa5cK2UewbNwIfkSnQXw+QfqfQtxEbdrD+aBZu9YRGEAbB5DrWHoaFOh9wI9zcvlGJOAStWak7Ur61oZ/AkUXN0yYXWj1vtz7+Kscu3CMWd7BqjA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?DaWeOPM0rFyvex+WWp5ITc8x4qrI5NGNETDRXepVXtKOhi9/+dvqGxNncnC2?=
 =?us-ascii?Q?bJtZTthLSeN3n8g11s/dNjMAzIjn1/VAtr6OP3QfR9R37W5h9pnqXDy3sDB3?=
 =?us-ascii?Q?RKtleIKTKJgvyOhN2XBiH2dtXrvwwYKLNIsq9q7XmIb5jP/eJnF8igtO2t+1?=
 =?us-ascii?Q?VeyZFdOqSVq42JdrWfAw/fxcrzfOQ1fsH6EpzxAI5Y7T/yZafCmpwkmv1qPv?=
 =?us-ascii?Q?s6QtsQMU/5W/s3IsWm3QSLo7fFoPU6XXbvXuLFDU/lQI//HQDPLCOiWwdOHp?=
 =?us-ascii?Q?/nI3yVtZiFLqE6OiaY0cuNPn9xbCXBz4LdJ032yHIK7JNneIWRBfRu1eTI+h?=
 =?us-ascii?Q?FXRsou20xrvMjnvu+hwb9W5e7NcL0RqnBRZb0Z/4KUFRs+yKwc305QD6ipCf?=
 =?us-ascii?Q?9SDR2O9wEyv4jlsB40D9CehLALM5bQXOEIK+Yci8HTouxU9Q12+aGjKttA4F?=
 =?us-ascii?Q?JZrS5EecPXOPzCnpX6GbMAQVrWvqZC4ZPAm+6Ie3ea/FOoVoElAOmE70IgKk?=
 =?us-ascii?Q?MXKYpfcimbNVGIeFMEY3XcRNFSUH1+4kivS3xhDo1kCVeqJu7do65iRl0QKe?=
 =?us-ascii?Q?aih4+SEqUx654qV94j38IvP1nAwZIykMcRNc7O90jDlvzGC+3P08UaOBZAee?=
 =?us-ascii?Q?R8NJBgBszRHD1j0U+bFX95Zn9Q24eJSPYprP90LbG9PcI/gwtsDzZxIpLRty?=
 =?us-ascii?Q?jLpU46dpAsNsSV3DJUiEchZMhjiKvyEK/18ii/icjY4Frd+teqTRLyLuMDR4?=
 =?us-ascii?Q?ZRJKm9LphwKdrM6orWgnKJ8pZ+7C7qp47sCmcWHfl9RL0CV9mciFKBUlrCqb?=
 =?us-ascii?Q?+M1VjSIvWKDtA8a3WCVXVys87fB8bp+YMwEFxg0lg+UflqVp405cAi96u/R5?=
 =?us-ascii?Q?3FcZzbEol7/wu8dE1i5kxF3P784DjjGsu2NMr+76R4z7SwLAYRcETTk521Db?=
 =?us-ascii?Q?QwYpxhma51yDPvKF3aCAGgq0pRTNiNu2WaG1QzBAA0dhfkuNnfFMb7FSr73d?=
 =?us-ascii?Q?kswdUjWNlPf88AKcqeqsqhbEBOU6MWlspG+jCv8W47cNMNmFw8r2pw2Ivpav?=
 =?us-ascii?Q?k0x1vu3WqRGwAVlkZrgt/SH30SgjeDjlO6NEFk0gqVo7D/O+ml8znDwOOR3H?=
 =?us-ascii?Q?4Wzf9fAYBIUYPc3/lxw1G5+pjCV6IqcmJrdIYEV5N6vIh2WRPYe6eUNSdfJE?=
 =?us-ascii?Q?MKVHfFpYyBD+rQLjSFCQO+0MMr3wkp48zhB1pgpbyne2S/27qxNauKfpPc+9?=
 =?us-ascii?Q?FvGd9i5NmdGS27b0YSbVpx+WHQCD+jwfsI3zd96ese3uuCfzzBThHc045b+P?=
 =?us-ascii?Q?kKlAhCqPsMJJXw9IN8/40bQvzUYxKYFHAaNvM1tTc850yM0kMM2OR32cMZ+j?=
 =?us-ascii?Q?uvYK6IUpBDrpfg9vUAFE0ztnR6hlXQA6QCmluRSjgyNpnpv9mBzOVrF+tC8X?=
 =?us-ascii?Q?4mhf5EhwmR5dKV6DTCW//KlY+d8he1x7siRCLd0HdehelPvY9DLksN33tX+5?=
 =?us-ascii?Q?Q5twCDgk8BMP3DRTjTk1LPaPqOhgYY/wcnRqsQNMSkuIhVqblRBOwvD00v+w?=
 =?us-ascii?Q?FmWBOxVlrKqpM0TDPSzLcROy7L3OKxFZO7AQRMsGdEFP0xDYLhQ34N+Tc4If?=
 =?us-ascii?Q?of+Nq/+Cdp2GnTqDFe2wwOGxF9aq055hHlhpxuRtalbdALHYLFEwaxbhY5DQ?=
 =?us-ascii?Q?OzjqueXmRCQYJei5oNejuC9aLMCMIpF2lgOZOFggHDTuXSwzAY5FdjP6HfKa?=
 =?us-ascii?Q?vSkh0RQfm0sD5lMQQV5vDKvD+kSsVJ9WmKFTyuORV8DeUwkI/FhENd5aYVWB?=
X-MS-Exchange-AntiSpam-MessageData-1: +FM0dUh4+P1/QtJYMlCx5UgQ7Z0z6huRmuE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30868a1a-e1ac-4785-a287-08dea6ba5ca6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:14:08.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+VO9Uo5tAfPp1U/YaBx1A7LlceKzVPqUF/50dds5Vafhpn61OZf6qHabYRl6Z9sm9SsgcFDEpimlVx67Ms/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319
X-Rspamd-Queue-Id: 11CE14A349F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7459-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,glider.be];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 01:59:53PM +0200, Geert Uytterhoeven wrote:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

Thanks.

> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
> >  int phy_notify_state(struct phy *phy, union phy_notify state);
> >  int phy_get_bus_width(struct phy *phy);
> >  void phy_set_bus_width(struct phy *phy, int bus_width);
> > +u32 phy_get_max_link_rate(struct phy *phy);
> 
> This (and all the existing getters) should take a "const struct phy *".

Yeah... Let's see what other review comments pop up (including Sashiko,
which would be seeing this series for the first time) and decide
afterwards whether to make the argument const for the new getters as
part of a separate set, or in v8.

I don't think that modifying the existing getters is in scope for this
27 patch set.

