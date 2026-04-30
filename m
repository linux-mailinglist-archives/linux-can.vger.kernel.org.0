Return-Path: <linux-can+bounces-7437-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFGtC7M482moygEAu9opvQ
	(envelope-from <linux-can+bounces-7437-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AC4A17E7
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 439F0302865E
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCD410D3C;
	Thu, 30 Apr 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjiV9HTC"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D13D7D96;
	Thu, 30 Apr 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547239; cv=fail; b=A43OgDdDteDLG7F6B+x8vk5VAJ1e0sEbO9x6FTsE3g8Zj1jk2NhJlNSowheozIWdtBdLiWrWmELtqRyWx5IeSG0il+aD9H2j3cSSs+CMroHnnswPBd7LwOfdUQJ5H3FI2V3fip/n1XZI4n0AY/cge7kuoLMI5PLF1d2pq5hDFlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547239; c=relaxed/simple;
	bh=dvBRrATornj2eiugNNNEUIP60jaQm70LKt/SjhxHvOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbRIu2ied5Rttqj+2kGY2ZYHaB2fSC52hQucpGiqZLYL1MLfyuhg1P1lEZvGKM0bGi8LEEFDy2X4bhSPrV2EGP2IhfeQ+kcFD758hlOmlb1DnSnZGMugP1wpbw0KrhJXW0KZ+TplksePUTxXyg0LHD+xXIUeLVPNApipNqD/h9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jjiV9HTC; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy0Usp19MqbkkOvof7JpN7G+e0GXks2cjwDT4egj1ShbtdxbImW8UuSs3aSyehd9SIwQhdhAUWcLQAtIgCJeMo3eeJmrFTsB/TCQEa+X6+3naBk04IJIqNm5OYfBR0GTjLhn01TngY/Hqjg0xncFBptUhLlpQ22n11+itvKWI3LkVlGIuTQuDx5Wb8NHXz90alUSGph+k2F7ue0jcUZez8iZM1DFex008mXKeNWBkOKla3OfcOnPegEyUzlIGYsYwoQynizpVswlF0JLWtu2lxBFx4SvutyAmAgoniKI3YCu3wsW93zWozX/Chmff3B2NLaaICbLVCy6pf0Cr8//+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C5GLzETIdB31+F9qDSSi0MI9ZUshW5sERTXokTyvE0=;
 b=MT4XEbzS3WY8YyNT7Artp9fHZJmIovwK31NM1rxwsV5Mb2YfOvLBxJFS1jWyfywbadEUYWX/ry9ahe3vgEd1ey5TsTFXyxxwWZe+A5Ldl/yzfIh+o//3RoYJaar+GxWdf4yw5Y4wy7xBcmg/4HUE8/A3DoRsOMT+t4FIzkOfE3JHIHSlIdWGsWdIUaMZifqM5zUQCoZjn1zUyloltoGYaX1eiYtDcdh7NZJdGPCAGuKuZgwClwfhmk00CXM57Y2rv8AYm61KymokVEpYADzUfZc5I2u6uJu1loOYoirp2rAkzZWx27Y1wTtvONvGXmVXfl55AXVE//vR0efoir/XBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C5GLzETIdB31+F9qDSSi0MI9ZUshW5sERTXokTyvE0=;
 b=jjiV9HTCxNrnIQ3hOOQind5olgyCU0yoZtuUYOxeunuOSmRj5DIB+4ceYg7ch7CQasqvyBhR77oUqmfKuDw9pIJnSxz0M+OFdS6w26xxF6mbMlMpRiNNKpUBpvciOp2rwEuxKLlJpcBwDQhFm1RBqaOldwMtP2mk9DxaZ0vK31Z0CXiDuViUCSy3HSRrVW8TxkBSviC8Ii8hCfQy/STkWzztzxX3I2ValcrDZmBla2I8vYMAaGgQPtRLQAPcsCkhup3nvjT7oMG2/zzifufeiElt6hf9DDuJKYnNlwnyLIJNg38bmjnUlhMXhtm+9+VBP1HQgpGhXEG/Q3yk5utFag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:10 +0000
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v7 phy-next 08/27] PCI: Remove device links to PHY
Date: Thu, 30 Apr 2026 14:06:33 +0300
Message-Id: <20260430110652.558622-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc2859a-ef22-4de6-9971-08dea6a8a00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nQm0TSrfsFOOo/9BxzXDi8RTUGbm1m8nmQSeu2+9hWJGvM8LZT18P2ZkGDXo23o+2rwaFKI+9IEourCvHQfiUL9F6nzQY6oEwK52FBm24xu1ajgpU1ITgDGuU6pCje8PI/0KzsvSKA6UJQ3e9hvE3ErLdMS2rfsXvkr/amRbbXIzw+toBoYP1OikkjA54grcimu5gy/UC9R7ZsTkCBj2ynrl/g96hm+p0U+YUHnokglyqSUB8C0Y/s86js2r6YfPS+zPj9vaac49/0ZqcrcOGXidbmf0rZlR5pc5GNSgyQGsrGirGC/73S1NEOwU8gYaggbuAoT3WXQElPg8RQOwunnclDPMQNtZ+1DXlSLdl9KWjkK478uee4aT8PrC9FjCoRoosTqJz4aQkGoE8ZKij9btJz0M5QvNb0OwOurVWQXBgD89EIU2bx9bpbDnD/LS08/RXc4Mgxzqf5NzYp44lFBpXIW4Nk+KR+vWECnykshGgFygSXYZy7bsme27GNgamausY0NMlDAo8XnlEuWeiG0Bp/mouDjJFtTLSZIDxrzLaI3vpxmcVblIt5DlAQbmEOJX7+mV/sBnsk0OdDxglsDv4VuVo+GUnHbVw/ofqIhZDKaWA/Y0CNabzJ46yoXwSIj6hlgWes98Pj6GzuOsxuNamJeQKLo1bwwvsm6Iu7YeweNMJkXXK/xzxgSkEEg57XW8EMmrv6RKkaZ1GQ3IcPLs2VQHmpjvPud3OnlWZ9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWw3Y1ZIL3RRdFBNRkVwdzg3NWJWZlNseTZ5NWJkYmVTZjNlT3pPRm9ROXNB?=
 =?utf-8?B?OXQzQzNLVUJnbDZtaXpzRzgxOW00d1hlcGxTbXdNdktxKzhEZzZCcVNsWVBl?=
 =?utf-8?B?eXRTOUwreDEzcGMyOFY0THdqSzRuWVFqT3ZTejhsamJSZW83dGd3OGl2V2Vq?=
 =?utf-8?B?SlRYSzJkNXk1dGVvZFN3SEIxckxOS21hZVBjak9vTThNb3IyUno3Umhtb1V5?=
 =?utf-8?B?SlFCc0xmcU9aM2UvbitxUXhsNnVTYXQyTUxtME9zbytacjJ2RncvRUJ0MkFT?=
 =?utf-8?B?SnM3ZmgwMHFCQ0haR3hvY29ZVlFGbVpycTl1cFRqU1lCeDJzRUFGb2pTMVJG?=
 =?utf-8?B?Unl6RmN0QktRZlN2Ym96d3poNjlYbUFER1BPU29MMXUrQ0JKVDN3djBZaFRY?=
 =?utf-8?B?RjNibXZIMUVNZHBtMTZWMURoa2x0andTRVF1OHZOd0VoelllSHJVNGlPUVRR?=
 =?utf-8?B?c3RDQ1plSlQxYnkvRkZWTS9MZ0x6TFpXcVpJbEsrYjZZMGtOaGlCYlhtdkZY?=
 =?utf-8?B?QVVrTXR1RjU5RWdJMUFkcUdORkNVaTI4dHlpZ2Jza2dQLytzMHNmVXFFNytn?=
 =?utf-8?B?UFVWRXc1MHlIRVh4cnV3ZEFSbVZJaGwxSGM2WWdqaElDS25SMlRIdWxUT2pV?=
 =?utf-8?B?Q2F1a2xjaW9ybjJZeXlRRFRSVVR6OU1rdjlPWFUvRGFQdVR1cEJrOThTTVN6?=
 =?utf-8?B?UlQ1bVRndE4yQzVEcW1ZaUd6VmlQamduR2hxZXdmRWRjSjZ6Mm5qMFBkc2Yz?=
 =?utf-8?B?dnpXeGJhNUpOS3psUlFHU1ZtQ1dLYitRSFJETThtOWsxWUIrVjZpYytlbVFQ?=
 =?utf-8?B?ejJ6U3F5UVJkMFB3RVVDN3ZYNEVqbnFXQWJReThJVmc5ZFpjSmpYM0ZDeGt1?=
 =?utf-8?B?WXBJNThub2h3N0hCTTVTYU1NTDJDNTRnTE5oWVZhWDIvMjR2ekNsS0lzU1Z6?=
 =?utf-8?B?SlY3eGpXQXVxYWt0L0dXS05EUk9vUnp6ZEZ5QTU5OFY5T2ZraFRKQ3lUQUtE?=
 =?utf-8?B?MGRFUEU5Sm9hWEY1ek9wSVNFbVBIWlRGVE5QN01JTnNQd1B1UHgwM3FZZmdG?=
 =?utf-8?B?eUdLOWdPZjQvSVl3SDFRV1lUMktpNFlIRk55K09JZk9WK29qbzJEaHR0alM3?=
 =?utf-8?B?QlZ4Y2k5dlZ0K05QeDBldzhQeHJZb2pWVExJVDJ6MjBkcnY5S2lFZURmekY3?=
 =?utf-8?B?NVFpVkZSS2NCbmtFMzA2K1ZIMzVEMThIb0lZdVMra3lDWFJ4SE92ZHN5aysy?=
 =?utf-8?B?c0t2NmtkaW1teHBvUWFZSHRrSko0dXE1SGRnVGlmckFWTXR3Z1pCTCs2K0xi?=
 =?utf-8?B?MCtYNkE0YXlVckdXdW1mcjBUZWJLYkZ6azlKUUdkeXY0R1crUzBsTyt0RnhY?=
 =?utf-8?B?QXFGYUVObklCbGZLV1UySERxbXhrSksrVytPVlp3TzNoSHJmY0IvcXJmalUy?=
 =?utf-8?B?L2JNUXB1bDVWd2p0MURzR3NEU1ZmQURDYW03NEpUWGFBbjZJeXBhcjNCaGkz?=
 =?utf-8?B?SlpzZVRpdDRFTXVRbG5ISVV6UjNmRllEeFNza25NZ0w3b2FCTXRraTVjZWY3?=
 =?utf-8?B?eGtjSkNQT3FpckNvMHo4UlAyd3A0YzVqQjF4TG9wMElJZXBYZ092aEJSQXh6?=
 =?utf-8?B?eHU0RHAwSTUzTVN4S3BHN2pTWG94bHkvWXBOWkJTeVMvcjh4VzJqeWFMUVo0?=
 =?utf-8?B?T1NZMjNZUmZqOEIrSzVJb0Ryay9UU2JZNWVhSzB4UWpTZ3AyRlgxZE9YbmJj?=
 =?utf-8?B?UFdNZ2FsNE1KbC9RZHVCREdVU1FDVGdDTjc5cXhtL1JoTDZtU2EyM080cyt0?=
 =?utf-8?B?TnFhRVdibFJKdTJ2SnNkR0FoSGhSV0pzOWZZTThlUENCaDN0TG9OMFc5dmMx?=
 =?utf-8?B?TWN2NjJKdm9TMFRZZjN5eVQxU2lreFU5cUlCcCs5UlFlRVZOT2dyVUxydGJT?=
 =?utf-8?B?Y0YxYTk1T0twci9pdVhGSUd6MU5KNU5lV2h4c1FDUHBFbCtvckxXVzZ4dy8v?=
 =?utf-8?B?ZXFxQTBha2diNDFIQUFaMmJ2SXhjMEZKU1dqSEw1RmJ5N1FBUEp1eFhIN3Y5?=
 =?utf-8?B?RjJoZUhWVURyMERGZVB2RXN0OWw0Uk1ZbjRhbEpyRWN0MlpraWpWRlFPaGQ1?=
 =?utf-8?B?Y2NoS1I2VEJhSi83MGJFcStqMm5tbXUyMkVIczNndkpaUzJ1aEJNSkNvRENv?=
 =?utf-8?B?OEZZdmZaR2lJcTJXUkZRYWRveDh1c0JKcVgxOTNBalV6WDVLU2FYRElvVnBS?=
 =?utf-8?B?OHg5K1JrZEZCa3dPR2lqWVIvWExWem8xREF0cGNGSmN2NWFvYlUvZzBtOVFp?=
 =?utf-8?B?VDZybVJZMmpJODQzU0FlQ0tUYSt5R3hub3UvZ3hybFVpZ0c0L1NZSklIYldt?=
 =?utf-8?Q?Joiu65nhO+rzY5szuoY/382gYS/AUTRE8X3Ha?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc2859a-ef22-4de6-9971-08dea6a8a00b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:10.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a44KpPttrr2qCZks8361sxkrrolPR2VFeCnJ+I/nmNQXuxwYGrXjO1nZOF76LEHTjSON3rgHm9igoJQNiYPKqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 0C3AC4A17E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7437-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email]

This is practically a full revert of commit
7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
and a partial revert of the device link pieces from commits
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")

The trouble with these commits is that they dereference fields inside
struct phy from a consumer driver, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order PHY
provider and consumer suspend/resume operations. All reverted commits
are from 2017-2018, and what they do should actually be redundant now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

v6->v7: none
v5->v6: collect tag from Manivannan Sadhasivam
v3->v5: none
v2->v3:
- remove dangling set but unused phy_count local variable in
  cdns_plat_pcie_probe()
v1->v2:
- fully remove struct device link **link from struct cdns_pcie and from
  cdns_plat_pcie_probe() error path
- collect tag from Bjorn Helgaas
- adjust commit title
---
 .../controller/cadence/pcie-cadence-plat.c    |  4 ---
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
 drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
 5 files changed, 5 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..fc39c01b7964 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba..0ac980249941 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 574e9cf4d003..232b504b5cf9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -82,7 +82,6 @@ struct cdns_plat_pcie_of_data {
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -95,7 +94,6 @@ struct cdns_pcie {
 	bool			             is_rc;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index cd904659c321..9c1aef4d0bd1 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -679,7 +678,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
@@ -727,10 +725,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	dra7xx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
@@ -745,12 +739,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
-		}
 	}
 
 	dra7xx->base = base;
@@ -852,10 +840,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-err_link:
-	while (--i >= 0)
-		device_link_del(link[i]);
-
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fe4836925c4e..cab9fad212ad 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -130,7 +130,6 @@ struct keystone_pcie {
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
-	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
@@ -1130,7 +1129,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1201,31 +1199,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_optional_get(dev, name);
 		if (IS_ERR(phy[i])) {
 			ret = PTR_ERR(phy[i]);
-			goto err_link;
-		}
-
-		if (!phy[i])
-			continue;
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
+			goto err;
 		}
 	}
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
-	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
 
@@ -1235,7 +1219,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1250,7 +1234,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
-err_link:
-	while (--i >= 0 && link[i])
-		device_link_del(link[i]);
-
+err:
 	return ret;
 }
 
 static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-	struct device_link **link = ks_pcie->link;
-	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-	while (num_lanes--)
-		device_link_del(link[num_lanes]);
 }
 
 static struct platform_driver ks_pcie_driver = {
-- 
2.34.1


