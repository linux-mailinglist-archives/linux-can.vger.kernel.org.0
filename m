Return-Path: <linux-can+bounces-2106-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1D9D214D
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95711F224EB
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1819AD89;
	Tue, 19 Nov 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IMNwiZni"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A517157469;
	Tue, 19 Nov 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003866; cv=fail; b=PkElo2SGQ28Iwxza3ps+/AHgwBoKkSE+5BniIFDUhUbaeBvVxb+bg1Mx7zRhhF0RDCgnu1WNWqaDCKFJR2MU6U3GWw4gn/7AUf8E+8H/KBBxIkLiyyjYFg3fWwvV8qGs7Dyxieum2eJ0qE+ZhNfwYpwQllAlR9cw2RHx4Y1uzE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003866; c=relaxed/simple;
	bh=2lC5tG3oSaMMhEya7MsoBHOSGN2fF94UtT4f2Wd32sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z98m6Qn2Ii/pOBfHdUA0mrASe3d6YjPswEiLS2QrW00PcEKhdKJQBIvgAUWbu2YMgWkObvv00TJ64xlrhFY9D1rOV5RlQxVnPubRDbyE4RQkpuCqsRvUVJ9XLwvQuMoCuBlod5oeqPhRvE3WNDZ00Qs+k2hhdnz3o+I/nUkD0+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IMNwiZni; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7Cd1Fu2l2nGa4On9FUzqoLmbwyoA5hvp/8wKMdnc0+9xsYAFTMt1AZyNKaIH+NpqLd9HlsnX0KzcZkZ75F6FjU8SRl22Lx7fp1LSpvChFEmaPf51UO0KutHIQucNP1sUFhGKL8zrH8YWouuWzdrYCExvhCTgydOkekn90yKgq6qr/uPex+ilJeixpNN6JHInwcBOi9beIGHWU9sTDfMcccoVlvwkISxXv01h0Wuqz9hrylanWSf9hnhR3PMj5U/KtJEtWRETyj6my80HInSdyrxTEXqii6PcaRCRrjc8CpdUfJIIeOdJxt+TMXHQwTd90aJXexi2egHn/orB5b93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm+Ou+Qc6KomIYnh+sPgqRr7u/wWjPGAlWW15rwFxcE=;
 b=ZoWMns50cQmBcOuAmmnzoC5WlcVqTjVKqSfZNXhlGf5TZykt0yngjjl/k9YYh+BN1jku2kPLUYavOcsndJmAcLVNuid4Tst2ruQubfTHwmX8KVzsm8w9pbFl5QC9XsSqC7WHNjteAJWEDlqAf0kWD1NbhNe70p5UfTa1Vnr8pYb6OO5vwnxj+so3DSB4BUAmVXMESKZjr18Anh79WOvoobHFgVGuS87hoztrP0ATUWNH4whN6BoEwzEeL0O3moqqiLKu/zwZ7aMVJikxYKuS7IoSkiDmNDtL/Y5sr4AfSHDK7OoI2Kid42alD3vwKFWKqKcyVmmPKhC7CrPD7q/VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm+Ou+Qc6KomIYnh+sPgqRr7u/wWjPGAlWW15rwFxcE=;
 b=IMNwiZnigfRknjgOacOKw2CpbSwthOtIPHnp2WPUpG4Y2MfCF+ozsLFJ6TT/6z0b63bDF1mb4D4JkmLy8OjgWWjku+ksvS6K3zklfpwoHrFtlJ1r42ENBxirb9u/pxYyh1l4UwP0XAbdONTbaixXQ7pdqt8/zBBhLMCEoR5WQwKw2oRDhiBLabynOvplQyjXtoxAnbtPgGjqTGHSQYiyhkMQiWfUQYVgWMkLz7zSjjv1/DS6WHb5OB1DWjX2mjFyzX4TOOxhD4Ye60JRS0QrIJgMdYtl+hdQ/sgRt4l2oEijQtZO3TS8fTGeATujq1dY7g6sjzaP0faCorO9q/PyvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:10:59 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:10:59 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Tue, 19 Nov 2024 10:10:51 +0200
Message-ID: <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: a832a998-e519-4e2c-2096-08dd0871b39b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFF2YlNXWVVSVWpMekp3Y3d5cU5WZ0gvSWtXYnVMbnNPUTY5ejFaK2RwRGhQ?=
 =?utf-8?B?cmJLeUQ2am15WmczTVdTUTlzZnk5U2ZOd0k3VVpwQlkxY2ttekE1NHpoZTZY?=
 =?utf-8?B?bjJoSGg4bnBkVi9EMEVzSUVTR3llWGt3cktWbmlSNXo2bFc5T1liS3MvZnRJ?=
 =?utf-8?B?Z3N2dGlvdnk3Z25UTjJGNVlGb21zbGwvN1czbEUvTS9hWnVGR0l3UnZzb0Rl?=
 =?utf-8?B?VjhyOUorOThDNzJ0NVRYckdmRlQxcVIzRWJiZnRlL0Z5Q1JpZ3Y4RmJlUnds?=
 =?utf-8?B?dTEvdDhqMFMyalV3dW5WT1hCMjVZSG9uWHBaVkZDbVdUNGRQS2V2ai9kd1NS?=
 =?utf-8?B?bk5YUVBIYWVHUUUrUEhKU2NrOXkyaU0rSHdoMXFWWmVVV1dqRi9sY3dyV3FV?=
 =?utf-8?B?NGFxVjYvWXZYaU01RmpSeVY1azhzTTZvdUk5ZFh5eWNTN0hIam1EVlJHeFZ5?=
 =?utf-8?B?VU51Slpac2ZiMU8yLzdJN082VW5tV2VUM3ZKQllUdnNMYjE5U2psQ0tXS2Ru?=
 =?utf-8?B?bWJjRzM3eldMN1VjbkRMZ1Q0YTRNamhvRkxMU3MwajFkNlNFYmVtaVd3V3hN?=
 =?utf-8?B?S0t1eUp6dUpVWUZOUU80ek1DMFlKMDVXZS9RaEJ3dklTNnNUUHNKWDMzVDdj?=
 =?utf-8?B?NWtRT0NVUGh4Q1AxMWRTeTJGMjhhNUFyaUw2YW1xM2hIcmxIODg3cHRlaU5v?=
 =?utf-8?B?S0Fuc1JiaGw1TjNVUncxcUo1bDd4OG9MM2lJV0tKWHBVNWh6Vjc1bWtXMHBn?=
 =?utf-8?B?T3V6Wk9KQlZ4Z2lVeENzK1k1RnhOSW9NVmx3amFqOWFTQmdlTW9BZmM5dlhz?=
 =?utf-8?B?aTdzVlk1ZUpuV3dZRjVzZXNoQmRHU1AzSW91NmxKKzdLb2lRMldkRFI0cGE4?=
 =?utf-8?B?YUgza2lVZGRvTmhUemZjQzJnRTUwZkxBa2xhOEFKOCt5aWZzY25pOUYyS1hK?=
 =?utf-8?B?R29QSUNaWjhXV0pNTFhDS0tjeTdEOHIvUFkxR1pMUnhvZG1oWWJ0djBhbktm?=
 =?utf-8?B?QWlOVXdzak1vK0t0TmZVL2tOaU1HMnBlQVhHcnZBb05YQ3VsWU00ZGw1T0dR?=
 =?utf-8?B?OUpvalVWUkh2YUtZaDVnMlZHdWJIYlhmMDlSRXZTS21wdGdFTEc2WjUxa3l3?=
 =?utf-8?B?NHdGWC9Udy9ZMUpnLzdHbU1lTktUeFpTbVh4YWg5aWsyK29RQ1J2YVpPNUVh?=
 =?utf-8?B?QXg0UngzSFU4RFlRd2g1UEdDdyt4OGt3WnNVN29VSWtyT0NGTmhtVUFFc2Vq?=
 =?utf-8?B?OEQ2dXhGMm1UZ3VadXVsNzlFVjJDcGZudS95VWFyVGl1N2xYeU5vb3lienBZ?=
 =?utf-8?B?UzVqOHpLLzZPTXpWUXV0SXpabWNjTldURVZWU2VoSWlZdTk1YnNNZEhvWjht?=
 =?utf-8?B?N2txRisreHd0WEN1bW1YaVFBV0J1eHV0dDAzNlVjYnBWOG1SVUltWndCTkJk?=
 =?utf-8?B?MXRteHppTmd0d1BERllQRHVlTGExcWxkMWVVM0xhb0F0MWtQRGdHS1FpMUZC?=
 =?utf-8?B?MTRFR2lTcjRPS3F1OUxmZ2FOdkdUQmV4NUJnMlVvUkJ6K3FHbjA5UXZWVm53?=
 =?utf-8?B?TGQzMGEvSDNLRXYxT2E3Q01hK0JRTmJFMERwdWUrQVJ3bWgxZzd6aFZsNVRl?=
 =?utf-8?B?K2hON3ZaamRDZHgyZGx3NjhVVW9kWWxkQkRmRUxEd2xrOTRtbU84UjNnWUFC?=
 =?utf-8?B?a3NOK0pYQkhwV0JJMzR4QVVQcm81VWtSQyt0a3VGSUIvVzc2REVSVGdPSWlk?=
 =?utf-8?B?QjVESkJhcEs4Z3dBazRyL3kyYVdIRS90Vzd2YzQ0NDV2Qm5PQTZ4MUNmeW9i?=
 =?utf-8?Q?hdxKmkdD1Snl3TX5ZMldrjx4NgUwgzd8HwXgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yzcrdllydm41ZVIwZ3lWdnp3Rnd5cmdVR2RoWkdNb3NoSkxTSzdxT3lvVldN?=
 =?utf-8?B?MXhhTVduajhYN0ZWekZwUlRKNVpxY0o1cGp5SVFrMDY3bWNNelRsSjh2ZXhU?=
 =?utf-8?B?ZVg5S3lGa2dNS25LeGxJRU51WGU1bTNSZVZJM1ZZMXNUc3pOQWtsUzJJQ1gx?=
 =?utf-8?B?dUZ1YWtSbWJtU0lHREhEVVMwb2pIenptL3l3ZHF6WVlOY1grYm9tTk1IU2ht?=
 =?utf-8?B?ZnpNWHhrVmJYMERMME4ydXhUMzVHV3dnNkZVdStoT1NMRnRzRWNuNlRGZkFu?=
 =?utf-8?B?VFlqdzlXY1VNeXdyanl6bHNYS29PUUtLZ25vQTI1ZExYKzNNbGdTeGlqN042?=
 =?utf-8?B?N1IrSFR4blRrU1Q4ZUs2MkJGeExpNE4xSVZaNUZHMmFsdXBUZjdWMmpic05G?=
 =?utf-8?B?TjBHczk5aTRiV1JUUUZicVdYRFlISlJObGoyR3BIUFdMazNnaDYrb2ZJMnlp?=
 =?utf-8?B?cmQ0WXJITjYzMldDR2NhLzlIbGMvYk5oNDZKc0RMYXc3bDNaWVV6Tkp4TnpG?=
 =?utf-8?B?Q3BqZDZuQ3NUZzAxU2ZJQWpNNXJQM1lYVW52cmlKWm5SS0lycjJrVlR4Y3FR?=
 =?utf-8?B?S0lWVi9iQS9WSzlsOXFJMCtuZkRCSkpuTEU1TmVwdkdIRDg4VzVMeFd6ZGEw?=
 =?utf-8?B?U3ZOdDYvdW9IWGtuVFVxQkp6WTRObm1DOFV1U3RxdWdaK2FFaHB1MStwZHZU?=
 =?utf-8?B?UzVqbzU1WWQ0Q1NYczdkVHlTN1lEYlNxUVZXSFVDWWxrenpIUFF3eE5sUkIw?=
 =?utf-8?B?Z0FVOURESy94UmEyK2VsUmVheUdrZ0NjQ1JvaXFJVnIwZ3RUUlYwdVd3U2Jl?=
 =?utf-8?B?UTBQZ0N0Wm01eW1tVVhiZWNrRXUxL2ltRDlnbTJVYnVGN3hhYVB2Z2VCeUFk?=
 =?utf-8?B?OTFUdE5GZ0YvWmJIS2dZdS9ZRkxrcmhuOUVkc0ZzZk5JZEFheDYwNjkvSndZ?=
 =?utf-8?B?bFdkNHNnUU9mOUVUQ3NuSVlsaEpGZTR1K1JCcWhVdGsyc09uSzhFUFAxamMx?=
 =?utf-8?B?S2FtUlY5b1U4ZkthNWd6eGRJQUxJYVc5NmFPVmliYWIycWMzSFNtNXFFNXZj?=
 =?utf-8?B?WVN1TnRwSi9ZTVRJS3JrYjhaRW1XeWlCdERrU2U4R0pVVVhWWm45UElqMloz?=
 =?utf-8?B?YmV3RXB4NUg4L1A2d3hNWVBEWVpJT2ZpQk95RlR0TlBDMnk5Q2cwZS9GeTJS?=
 =?utf-8?B?QUdQV2F5dVVyWUo3ZWFZZkhoQ3N1VmdRVEwxUmJQcnFRMlpXcVRaTWJaZ00z?=
 =?utf-8?B?aVorUkt3Z2ttMnJoWW56T0tDNXNEbW1PaEdEbEVRSlhta1Q4QVNMNHZiTTRj?=
 =?utf-8?B?N3cvZ0ViWVJKTU5EWkxnbkgwcW1kVldkUDhyZTQweG1xa0c4UVMxYlhpeW93?=
 =?utf-8?B?a2Z3YXg2dEJFb1FtUWROQ1hUQjFpUlB6SmZNc3lZbS8rZmNkYlRoZUxSMUY0?=
 =?utf-8?B?am9Va2VPU3p0Q1ZZOGFXSGNHRU1LK2pwbWVqRnZPTE9ibCtWaU1IRUhTbUVL?=
 =?utf-8?B?R0RpNmVSQlMxMURRR0VpWXN0d1FlMUFJTUw4RVB2ZitPYUVURWNBV0NNQmhF?=
 =?utf-8?B?SGh1TGE4R3hHd216aTVOUlBsZlZXb29XV2dYaXUrWEl1K3BOZkVrV1pGUHVl?=
 =?utf-8?B?SlMvYnNLeWI3MjNIQVlqWEdYT0VmVU5zV2ozSXFKSExzUGRNKzJGQzJNRVR5?=
 =?utf-8?B?RWJTYnhoa1FCa1ZEaTcrRTV0dy81LzVDbVlkZnZPYkFDQUIzR3NOU2lQelRT?=
 =?utf-8?B?SlVURzNxd3BRdEJqZ1FseHdxSDZhLzNMTDUramVPQkZYdXZxZ0NwRWxGOCtG?=
 =?utf-8?B?N0RVem40R25GZlNVUUZXOXJtdnFjaGRmaW5sRmVldkw0KzJVNGRvMGo2U3Fy?=
 =?utf-8?B?czRWWFdsdWQ0UnpWVW1nNElOdVZUbmRlaTZUT21TMXgyNTltWGRKWU1QUm1B?=
 =?utf-8?B?T25oNzBEZHNZMW5JTjU2ck1rSTgrMXA4UkRMN3BrdGlUZWJwNHBmNXZYWG9I?=
 =?utf-8?B?MnB6UlhVTEt6c1BMamZkUUJ5K3BHajAzQ2tFRVZid2FMMUlFNUlKWWxsOVl3?=
 =?utf-8?B?TWx0RjVUcmQvR3hORG1GOHQ3dWJtN2xvRUtFTnZaNzhGVzJHbEUzclE1U3hC?=
 =?utf-8?B?Ky9Cc1pwUG9qZ0tGQVVwUjdlSlVPSmtGV0h3dDZ6TzJrdzRMSzZCLzFNTkVO?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a832a998-e519-4e2c-2096-08dd0871b39b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:10:59.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5gJ6pEXb7VJNS+xpKoSJ2BXRmTDEvCLKpylu2AZkwQoO2+uQBIgGhuBkwlQX+UavejYKp8by48rLZl5oB5we3czkuXyOT6NU6tDalR19y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..cb7204c06acf 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,6 +41,10 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
@@ -136,6 +138,23 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.45.2


