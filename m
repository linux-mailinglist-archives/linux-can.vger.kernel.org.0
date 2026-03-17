Return-Path: <linux-can+bounces-7112-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I48HUrfuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7112-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:10:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D92B3BF1
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA9E30B8C8D
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3943FADEA;
	Tue, 17 Mar 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ejCzzTKs"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46D3F8E03;
	Tue, 17 Mar 2026 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788755; cv=fail; b=VbvXjEHvUdg5fI6gqrhnCmrEAJsVciXgWCYWSFSVom4hm72dE0586lmE3jFksmug/Ek6cA5y/hwaMH+Kx6h+bmv20sZy/P5BaxFVkqzY8JIPlaTvVRsTIkEwg7iJKH8YajDNjbDm8aPao1SBhkSnryDFWr8x09BeWoqpu/ytrek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788755; c=relaxed/simple;
	bh=e40CwD5arWtp7KOGmVEiTFovmT+u+0JNNnp6vjWJxHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2BHE/DRaV0nVG2tNq6tVbhiBmRjXLUJSC1ePyK6JAYXF9J1OAXo+IFZpu+ZCvT3wMqoTR29eyKWO7jc7HRqWe26NWKZhEjSMFH4rfFJD/DKPJIaKqtsaGSct3TBIAlMi3Caf9nHyHkSNGlcl1TmCg9FfyEHxWGAASodOWI3T6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ejCzzTKs; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uop+/OUFPzi21FkaWwVgOsl9+NXLqYTdd9aLSC8mvV3SWgVYfnB/niz7gFiBzcUJhvKyTA23rKSfYUoPEURX3FqTuW4p7ewYbzsqJGwIO3wdE1faaA7NLZhIRNWxQvujYuazUgS+wrAjAds+Ex/Jw/5N7qWzPwh1v3hjYrn0yi4fWGrssxGWr6/7xu62CM6XGNodqW7WSxsDc0ldpOzpxEGGUa+OTDwa781CdZ827n5nZuIPI3HmXLGC5U0mgUNm3qdspbo7b8Bve8DlIXjAbhqizq7c8FaCNTYIxObrx3RirH8UWeNlKEfV0gRClHPO/qhCUVgIVYIcqyn1lOXQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj7gQiNNffFQp3eOaqRbNXvhydrUb1dJBJh1TF999t4=;
 b=gZQVS1+GUGI3ZMSwF9exLRF7kMW+ZvQ0X0bZD/i39I/pljduBHt2kEgtyLDTrcDJpcxUopuPcIWaMF7zbtPNh+O5HJjH4puVEF7Gml5OoY8CIiEFFW8Em4gBlSkQXi0gUAHKS9bNG+lWVkJUkQYKonr8WRwz7zaULqjVPsJZ9GAgfavbLuQCRn16+aAKYU4QXQaG+8IC/BWr8TVkLdHvBPF8qf6aIW+5lpGywvG+Dhvph+WeeBmXdahhwKa6QDlS8HeJe6UhQSDn3w2leRM3TIb8tCzgGpc33q1eKyepU9L9SvOR7roDSqV43sDfGXP12AjrA6Uo+VCBGKVrqzjU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj7gQiNNffFQp3eOaqRbNXvhydrUb1dJBJh1TF999t4=;
 b=ejCzzTKsoeukpKT0S3as9jI7Q57jtWr6L9Lzeh87z2b1KCsmPqCi6zJciqiWsDzjDIr7/XIMQYd4MN4RfpaENVIvLnZXtDo5a07wY5oTC8oqHzcX2BPaSzuWPAzDKYnrUZzh7nGmdRHrsexpdywXeJxYeCIkTy9GcCO9xZ6v8BSh4B3ICY2P7ifw6l/O6ZKtCA1QcAwrPy85Df18jPvLGbSJmwy3Yf5JsF2Xqu/OOqEZa5pxtyhhUFrMaq6IZtGWo53zgdehdtOGwLs3Nu50dZlSk201QanqB9GKVrDq5JA8cXYv6TZ7uFw7y94jFbAFXUC0MAQ47Fp1l0nyeV2/Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 23:05:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:31 +0000
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
	Heiko Stueber <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 phy-next 10/24] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Wed, 18 Mar 2026 01:04:46 +0200
Message-ID: <20260317230500.2056077-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0178.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d73884-a1e3-4fea-dfd6-08de8479afd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0OwxsAGG/7nAUXTZVN9Bn5YrvZ7eteunuZEDyTt3hRBhIc6WO0dIDR3iXoQqzsxoo8XbG4M2cAuJEhCU5bTKdJQ93C3T1i5hiK8mAkBGFVAcsGY9GNHcLk62JYxNb0Z599EQ1ym2jRY8R2hsxdAL1pk25HzluiIhQhk7TpIoJh28V5GIPwppPe/FQ+SNBXTPpi3Utjik8sCJVxGVTJZpDzf6NgmEnpja4LIQkaOfkvyJ94axWVMsx7zwh0chTl+75a8uwx5GawZrobT9eeb8DHQmlVe+TN3IQ6Q5dfDTZSRiNVQlwWlvP1X5fuEIbquzLJG5a8+IufKRGMSjsQGZAGRpfIZqcJRpJaNnbQhRojNtiv1IaxazD0JidTh2fyroylLZD3ahxZ2WBOHfaFc0ckg0SBEL2qa0YzB6IR8PCZfiDRLQXiuBCXS44HewUmMFuepE5rNYa21kr+2XlaCviX3qVvmb7UvagsdDGZEBOaqueP8jLtPaoq3Ee2QHbdlwzELbG2fglMzSz0RIvM7TUHhXQDsJSQaa68ogcl/sbPB35+XvWCMd1yC/S87/1QMqsSuhzFrecgP3pSU1nURXV7OCIiw8KJBhwRjz+rDTFnlVSivO+A6yy6I5VvDjO85tA5ps4PVY7uPe18PgAFOVincrT3ZSOoO0vnwYpSMcWLS/uXMHxFP5SHimq+LQPKyxtxg15lhCMNXJz9ZiIjkVz7hPAqY0KRKnevVwV8KdpV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXErRnEycnRzRS8zTVVpUmUwbDBOT0l1Y2NyR2U4dW0zWUNKOVJiaEYrSVNI?=
 =?utf-8?B?TEFka082UE9Bb3IxeGwwbGxyRFNJbGx2QVhOekJKVE1hMTRPcjhsdHQ0Qkg0?=
 =?utf-8?B?VFhTWnVWSnlxd2tTbjh6cjZ6UHJDckVHYWFESVBVZEMySWdjbW5MWFE5WnZK?=
 =?utf-8?B?UGFoazlRdE04RVNnbjYyb2hRcUlaaXF6ZC9sTUV1QUdpZXY3WHFDWk91T09F?=
 =?utf-8?B?VlFrYkZhYXlNTTBDSXFUOU1ETlgraktsRFk0TGlsT3JxelZqSk1mMkY5dm1j?=
 =?utf-8?B?OU9tM0VSNisxYWMrcERKS3NFZXVObVQybTZUS2Vnb3h6aDlDWkw0azhxZUF4?=
 =?utf-8?B?ZzNiWTVPUThnWmt2V2QyVmp0Ylh3V2NXU3BqaVAxUFlWa0hhRzRnbG9TdnlQ?=
 =?utf-8?B?MGFNYUxmTFRXbVhlOWxEN2U3eTZRaWxTSS81MjVua29KQmlsdk1nTFhCdG1V?=
 =?utf-8?B?aFVCcUQyUmZHUE5VS2IwTlRqbVNuOWgwM2gvK2dydjExOUoyeWVkSDhTdk1F?=
 =?utf-8?B?TmFmVkQxVVRTU1FvUlIvOGhkQkFySnNsbEFaZTdFSjJOOGZvM1JtMXpYbnJw?=
 =?utf-8?B?SkxKTUZYMVBDa1dkOEpRSk9wQ084Ukx5SUtUSTIzZ1dKOTlqYjczbTNUMy9R?=
 =?utf-8?B?UWhqL2JhdUhoeStaWUdTSHE2b2h6UXRNd2ZqVUpESXhka1pkQTkvWFJmZ3lN?=
 =?utf-8?B?MlpFYUxYZFJxMmMybXdPd3dHQTBqOGN5VlZ5UEljSDZVcDBJRklWZ3FEZ1hu?=
 =?utf-8?B?YkRjRm43Z1ZUclh1SU5zUVlCSDk0bkJRQlRDUmlwWTJIUzFnL1RZblhEeTE0?=
 =?utf-8?B?Mmp0S3VVMDRrek4wN0MydlRCMHpMVmYrK2EwM0dOTHdTU2dRVTJGWENvUlFm?=
 =?utf-8?B?bC8yaWlEOE5ERWg1ZjZzRmcycWFCUXVWSjRpUVg4ZnpPQnFWL2hYWkU2Tm10?=
 =?utf-8?B?aEd6aGNtUXcrdm5raEdUd1F6MFhtUU05RTdpb055WTZPODhkVUp6UCtmWEli?=
 =?utf-8?B?TlNHWjNlR01TeE9sN3ZOQW9zQXVOMmRkRFZBRVA3NmR0UlkvYmlVVFNaMlJ0?=
 =?utf-8?B?QzkrNUxDV0NHV3RxcVA1MXVmQlZ4N0M2RWlYRTdGME5HUjZwUGlYdEpGTkYv?=
 =?utf-8?B?Yk81c1ExU3NsUDQvaHZsbmQ4NGVNK1JQVmRJdENKRXkxc3UwbllSY3BPc3RU?=
 =?utf-8?B?bUpNbkk0SjM2UDh6QlErYU1kbVp3OUs2U0Y1YmxENmNrVlRsU3haWGR4NGRL?=
 =?utf-8?B?SmxCZ1Z1NXIzNzE1NmZOWm90SmlXVVVJSUF0dVhsYVMwbHZOYnlYdXVham9H?=
 =?utf-8?B?SEtINVJ1cGthNHJyZzA0MkV3RExYQnovaWlTdm9oM1VYN1RJTkNTcXplOXdz?=
 =?utf-8?B?TDRCTU9ZSE14R1hIekFGZ01EcEFGNVZHajhTWmJzYi9nTGQ4M0xBdHJTdEF1?=
 =?utf-8?B?K05ZakViQzN1dkJOQTRVRS9JdGV4b0YvSlVabmZ5dXZPOFpoY01uaVlvTGd1?=
 =?utf-8?B?QVVJWjdHbE11VTBjdnVBek9vYW41SHcwbTBkYk8yakoydmVnTkphV1FVMWVh?=
 =?utf-8?B?VVVBeW5sKzk2Uk4wWDFNK1FnNzZwSEN6YlhsM293ZXZySGJsMTVrRHZLWGJx?=
 =?utf-8?B?VE93TWJoUFVpQ2NxZ0owcS9ORDY2S0pkRlFsTFVpNTFkYzBGaERURHRwZWcv?=
 =?utf-8?B?VllkWU9uNm4xaTJpMnNwd3Q5N2VZa3dMcXpoVUVNa1VMUDJYcUljYTREbXB6?=
 =?utf-8?B?ZGs2Y3ZEWmRISXBpaDdlY1IrM3RONG1hRVhycUc4YlJvSXFBbkNzdTNvN3dV?=
 =?utf-8?B?SFdJMlpqcVJGbGwvSi9rVERDRXVTN1QxdDNJeVdtbkpTbE44clFKczlBeHQ0?=
 =?utf-8?B?V1RPeVp5RXdLNFlIVGhaa2tTQWNST1l6OXJuVkFQWTUxZTB6VmNKTlV4NkF5?=
 =?utf-8?B?K1Z2bU1xTkRZSlJQemxQczdyMFdTcUlKZkZJQ1FReE4rSG5sZFIxSHU1Vktw?=
 =?utf-8?B?U0FadlcxenNZRThuRUphdnErZ0g5R1RGSlUxMnV6S2ZqaEpIdjBTTVppVWFi?=
 =?utf-8?B?cXkzc0JncndpTGJjSUJjek5NOGlQeGNkdEplNUlWbmZGQk05TGlxS0ZFVERF?=
 =?utf-8?B?azYxRVppZkNCMFlDekRzdDA0cEpFUmJtMTZodEZJQy9LN0tGWm1HQytxZTQw?=
 =?utf-8?B?akZCa3V4YXlDMFVCNXlYVkJZK3dtbTd4Wml1dmpCZWRlcUpqdlpLQnM4WGgv?=
 =?utf-8?B?YStOMDBxU3Btd3dKWXRFTlBBSTFuZDQ1bHVUU3JxSndxN29tZ2NTNE1MbWg1?=
 =?utf-8?B?M2pxNlR2ZlNySkdhSzFNVEV6YmJMZjhtMjY5TEpoemIvYm94ZEQrZ3MyeUYz?=
 =?utf-8?Q?PkoEPU5HTohozV5vLheWfVA8fCZpB8vhdLTOvDUlEwH1z?=
X-MS-Exchange-AntiSpam-MessageData-1: hXzpyB+kVTINXBQmJk7CMcxx97nhusc2S/Y=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d73884-a1e3-4fea-dfd6-08de8479afd9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:31.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrgyRr+J0ffjYm3Be8DLa6pdiDMS3kGaXp8An1Pz7ke4c9oOCf8OzJ3DVxvOhyfEBKsZGfiAN+0HRjen6PxLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,sntech.de,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7112-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ffwll.ch:email,suse.de:email,clkspec.np:url,intel.com:email,rock-chips.com:email,sntech.de:email]
X-Rspamd-Queue-Id: 059D92B3BF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer
with a hidden definition, to be interacted with only using API
functions or NULL pointer checks, for the case where optional variants
of phy_get() did not find a PHY).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Heiko Stueber <heiko@sntech.de>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v3->v4: add commit message clarification of what is understood by
        "opaque pointer"
v1->v3: none
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..7abb42e486c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -537,21 +537,22 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev_of_node(dev);
 	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
-	int ret;
+	int ret, index;
 
-	if (!pdev->dev.of_node)
+	if (!np)
 		return -ENODEV;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
+	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
 	plat_data = devm_kmemdup(&pdev->dev, match->data,
 					     sizeof(*plat_data), GFP_KERNEL);
 	if (!plat_data)
@@ -564,9 +565,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	plat_data->priv_data = hdmi;
 	encoder = &hdmi->encoder.encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, np);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
-						  dev->of_node, 0, 0);
+						  np, 0, 0);
 
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
@@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
 	}
 
-	if (hdmi->phy) {
+	index = of_property_match_string(np, "phy-names", "hdmi");
+	if (index >= 0) {
 		struct of_phandle_args clkspec;
 
-		clkspec.np = hdmi->phy->dev.of_node;
-		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
-		if (IS_ERR(hdmi->hdmiphy_clk))
-			hdmi->hdmiphy_clk = NULL;
+		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
+						&clkspec)) {
+			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(hdmi->hdmiphy_clk))
+				hdmi->hdmiphy_clk = NULL;
+		}
 	}
 
 	if (hdmi->chip_data == &rk3568_chip_data) {
-- 
2.43.0


