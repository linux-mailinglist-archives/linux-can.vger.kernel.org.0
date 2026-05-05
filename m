Return-Path: <linux-can+bounces-7498-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNoRKlDD+Wk0DgMAu9opvQ
	(envelope-from <linux-can+bounces-7498-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1E4CAC29
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36B40308A886
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAB3F23B4;
	Tue,  5 May 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5D2L6/e"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AF3E9F76;
	Tue,  5 May 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975564; cv=fail; b=VXcU7yq3TtZ2N8kObVa1dpAnvxHls/oRkyxj7PDhk+MA0zbUs1Qxmv4YyWurscuF5uU7veBmNsN6lZGI5qhfQ0BvtchSHOPAl6//glvw0pgWCQejdrwlA0xNuc6DGh/rjXK/wsv8QY8/xeOq9B5MWXI5Zstjk7h1ekLO1XhBfiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975564; c=relaxed/simple;
	bh=1ljUqg4XIpjbgvqs6EjZdgMNIa8yruZPMzdYaC7BEqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArWPuwxHoINjTXhv+2f6+08aFzMPFxyLJn7ZEMViyBSlZbh8Qtc/jif5SzK+QbwIDnzHOQkwdgTB2QzBQ2c3gEyU5PdPfuD22/pOfDdw/17UWj8iP7fcksfFv+th6cr2fmI2oeFkRWJWahajoDPazA2kBYtCUyF2sUK4mIgJhXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5D2L6/e; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuh/Mmxb8dnkO1aWr5frqQFscVRlJccapKlT9wq1WVaLtTZMesthm4a3+36HXWlnTEaFdAj90ymCpH339Hghp6yzoMD600dR4IWcSd3x5K3A4iHKW/gGD6h9Z6gZkDpNTqjqriLsE23KJbsOH0HxbJdSYnPWEJpBegQlravEbYr7uCjUgsKS8UgFxNgG0K93Se8zn3SsuCmscaN7riO62mlG8G5LQes6KWZXF9ZkLnrbTIb/DytKQ1Bu9v34BB4/am++S/ZkLdHP8hAxmbDK+5Zu9wiXxE6CxwPep421CkUIJyb2ylwdZA2xuNcZgVJFxiYXnhGJbKkPgGzBWowyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h4UJ0BCnmpUdlD+n1nGOTWl4jBit4VSNE5zBKBHCQ4=;
 b=AIOBEHhY/dJ080+y7cgu4zBmB/jI9fjRw9FxIiPewP4He8aU5YNrTu4JVoqCWeec75RGozkqLU5OYCMnI2WUNUYNHO79dHB8Klcp2N0hK89bwBKkprDn9zP25madKLNKviMC56rcsS/WfuauwDTehRBpyBXiheS8xOx5ImoHw/06X31Mxnr9kRtV0WJXiUsDiV3JwVYAnrn0wkExy3n0sY9WCMUVEoVXnFzcfFy8toMi8ZvzczPM/DKJZNChgVcgtRSYs/XsVndi6yDJS9o9nQL6VKLp5j5VFkTMQNXATIx1NHV1jawypmZh2wwbC9iclB1awya1ccs55RQrMUfQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h4UJ0BCnmpUdlD+n1nGOTWl4jBit4VSNE5zBKBHCQ4=;
 b=U5D2L6/eqeScK7+Nu1tqU5ilxwdr0RotO2dFaNbjrf8/TrtqoRUESHHsThrfUphS5uCaKFZoM9xvCoPtJTamugf0axC5xkJKS18+RmTnywx0ExDoQY+bsPTi/cT3kdbNckgdwuOxO/msuczT8qAjJbzpcGBo6DiMJk2kee6NMqrysWkMme+91So2iVpbBhgqkuWSCdxTENPTW7v7W/W8nqXSf08lBwE8KLer9keOMuB87Y7OPn0OjxD1Ec6jlN2P8kHBjtdkVE7Tp3dPt1aowN1aeTtuWT0uL3npiFuGAT3/+MV5xlzEtfgYJ3goDwF/81UYE9Jtnsc0uNvpGaG5WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:54 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:53 +0000
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
Subject: [PATCH v8 phy-next 09/31] PCI: Remove device links to PHY
Date: Tue,  5 May 2026 13:05:01 +0300
Message-Id: <20260505100523.1922388-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: cef60d58-3980-4f51-46e9-08deaa8de4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kweEMLngJXrC+myHwAtMD8EC8yE55nDuv4BtpqzSGR5yKhXFvXqfLQbJMQQsQzA2Te3oaxtheW0yu3WTxr85iXAxQeRodSbojCp72m95fKTycl/dGP2t0zUs0jew0D+r9cKiR20bD5VsKQ4DB5npzPoQOEjQckQK5ZVPVv8K7jCA68LYzM0VZ2lSFny4H8QitxjkzLHVX+iVZkntldftHgneum1E98Ikl/96+7KFZ4onwxVZxVimjPodY2K8SsiB4SaQsFUGTkiR+Zu4urFHY5Z7RgVvqEUgFk4NIrPKi+DeOVTPme1YusueVs9n6C7ztbw/Z/Rb9udM18eoNsH72zloHWpXDrIg1r0a/wJL1Tfo1DNVj0gh24Y8ybQUxHDhfzQhMBRtuoR6bRgOowHmbYTbHNYm4j7qNMT2PHrK4Du+R1FMRokAg509tO6LT8T7hGtnEGBylu3ovn3+0R14kHRVO3Slu6lkfAEN3H5uPdhlcThTX3csHre6zlMVn+nnIjsLjJ5LgUOJQ3ajexuRHAQmfKvW9PpfjSInwPWtKGRjZBPL/0HyMFIaq8e6+JoqvXb/pRnYiLYJZnN2utkZJqPB8kRwEuUS9G55fb57kYebaQXGGffeqKpJaBYUgF9A0vTAnrmVlwJ0GY8H8tkKD+TTYAgW4JybweqjElts16cYgPw2JuYKA4blyBTf9Kx9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGdzcnhBb1pWMVluc3lRU2J2dFZydE1ZRElHVldsdU15K3V6MFhOc3NWTmVr?=
 =?utf-8?B?VnFrV0tMaEIzYnByQjdYVGw3ekxVQWJYYzZhNmJwM3ArczU1UTk0V2Z2Uktt?=
 =?utf-8?B?NFM3U1YvQU9rL2hBdldobUowbE5udkhvTXpqWEtPbk5ibXV4OE1iaHZIb0tI?=
 =?utf-8?B?Z3pCbFNSMzZJaXZydVFCblhVdHgwRTZPcHFic2lQL1RlUDc1SzdkY1R0T1Js?=
 =?utf-8?B?bFdFaEl1OWJaWXhBdmxhYXpid0xXTWxPSnZBSTlMcmlWVVJJWTFIUE9XRUZP?=
 =?utf-8?B?cWI3MFNiWEx5WTU5VUx5Y0cvOGdBcSs0cFlodVFxUFJLK0FLd1k2VDVnNHJS?=
 =?utf-8?B?N2UwblFWNTQ2ZzI5b2o3MW1oMVZGVVFOaVVzQkF0UVdGQ211OUl4RU0wYzlJ?=
 =?utf-8?B?MmZyNjJ2Nmo3a09UVG5YZkhoZ2l2dTkxN2ZGN2VZS2ducFF3RGNQSkh6VWc2?=
 =?utf-8?B?T1FuYktFdDBMT0VEbnh2NmRvdVIzYVkvVHBuV1FIOS9WWmR0KzUzektRbjIv?=
 =?utf-8?B?VTJJN1ZRd3hjQm8rUFltQjY0RTFzTWE0bU9FQ09ZejQ5YWlyMTVkOTFiRGFi?=
 =?utf-8?B?MlQwM1VmOW43ZnhiVkdmL2RUUS9IRGJjNnJrb1duTjM3cmIrRmExdERDWXpO?=
 =?utf-8?B?ZjBJSGt4ZHkrMC90UFZoaFQwSTNDaDdMUXU2MmV1MDhYYVVuWVdTdTQ1a2ty?=
 =?utf-8?B?d2NJZllvVW9ya05LOXFOeVF4ZENBSGhZK1ZYNjNBOE5ZQVhVcUx3S3NGTm5G?=
 =?utf-8?B?SnRiWUZYZUtobG5CNkFRWFBaa1pxeCtCdVJZTWQ5RVZOUncvYzJxN0FublZV?=
 =?utf-8?B?MUtDM1k4dkdPbWt3UmladjdrTnQrRnFTVG91SUU3Mm5IZVdhYTM0NDNpZm01?=
 =?utf-8?B?V3JoYm1heU81a1VlZVc5alVzN2ljVGlFQzd2OFRycGRneDFCMENhVldtTFZ1?=
 =?utf-8?B?NzlOYkZ3VmplU25OSFF3VlRydFhtTkNKVlArSTVLcmVoSTlxcDBuczBmbWdF?=
 =?utf-8?B?bno2T1hHU21oQlZzQ2V5QjhkVkg2OFhPbGtaaFFhdEtqUmt4QWZVZThVVTN6?=
 =?utf-8?B?NWhPMFBnSHV5NE9XL04zRjVSWG5idnFyUGUwa1FFY0ZBTytjVWw2K1BXRzdq?=
 =?utf-8?B?VGtDQ3ZobjhyQVVnTWVpNk5lSmd4TWpmaGhUbGFNNm5randCRlNya0dUVjRv?=
 =?utf-8?B?NmZSUlVaSWNJeGpIMi9UcFZrUUdMM3NPUDg4akpHQjdQaGN6M3YzYmRKTnlG?=
 =?utf-8?B?Y2lRdS9wNVRMSHVJcVVrSVU1QWNHNE9kZy92RFlqMkRZZzdoNmJnbWUzdEdt?=
 =?utf-8?B?Y29pczZnVW5HODZXZjBrTVI5c2plblVBdmJhcGZFVVd6YmlEMDFSMzFnaE9J?=
 =?utf-8?B?VkdCc0JZWVEzQmpndHZwUnIzT3lMdENDdmd2bUkvTDFqZWV2NjZMYTZ2MnZu?=
 =?utf-8?B?akpQQXdPOW5qZTBKNUQvUUMyd1FuV3dKaUpWbFcyaFhJSDEyMmtNVzVuV1VS?=
 =?utf-8?B?dVRyeWNpTVNBUUp5b1I4N0QxLzZiVXdwZWZuNUxIazJXOTVBQ3lrRWlZZ0Fx?=
 =?utf-8?B?YU1iVG5uYTdwaEtQZitKRkllWnk1Zjl2Rjg0RDJEMXhJdXlSZzZtdXZXMGxE?=
 =?utf-8?B?Nk9Nb2JzZlcvd3ZkWXZjVTVXcDZBRysvVUQ5VUZVajh1QnJETXZyeE5EK1ZT?=
 =?utf-8?B?NmJ5NHJvbE1KZVhxOElyVXlOM0lyVlFuMzVsYStBRW1hRmZRRkRUTEs1M2dy?=
 =?utf-8?B?bjNSQkE0aXQ3OUkzOFhkMjVuOCtzMm1uN2N5RXZkN0J4OVdCekJhdU81UW5x?=
 =?utf-8?B?R1R0NWprR3J4bCtDeXo4M0t6K1FHYVAveGdhV2w4MnZUQUhJaTZpWTVEZjlD?=
 =?utf-8?B?Zm5UMENlRm1vb2Zrd3dQUFlDRkpOMXI3bDVhU2pWRmVuRlhEQ1dBdjJpM1lh?=
 =?utf-8?B?Tm5RWmJyVEVRMEsvUFRzV3RLNDhEelpla2Z5VE9LSy91VHBwSjhlOW94b1hl?=
 =?utf-8?B?ZGlsQkdmcmhlS3k1NHZYUXJIWGpQdmJxOWNVOUE1SU1KVmFqZFphUUhkZFpp?=
 =?utf-8?B?OE9vaUhEY1ArZVo2WG5FN2xvNTZsMjJ2VG1ab3JBS3FmSnRNUjV4aTRlTkRk?=
 =?utf-8?B?RmxBYXlHWXUvcVJ2UTV2azdtWkxOVkNocTlHN2hhL0p3VEswd2huRlJEWnlZ?=
 =?utf-8?B?ZlluUTZTbjZWYmIvZGdZRXV3dzQrczZrNjJOR29tUEFtc0QrbHc5bS9nWm5W?=
 =?utf-8?B?czNxZCtNdGhCakc2WkRnTWRRODBaSEZrYkJrSGhpVHNKL3IvNi81MWYwQ3E2?=
 =?utf-8?B?YWczSFp0ckdpVXd6TG9XTktIY1Jlc0ZPSVIwNUp3dDBNK1J3MW5hdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef60d58-3980-4f51-46e9-08deaa8de4a7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:53.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp3hOfxwbRS87L0nwgVFZOL95U+C9sOtEs1wM7zzvHB7nEV59XOQhYE8iXXWGpnvbSjGQkvDLvNG8B8RV55uaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 24D1E4CAC29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7498-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,ti.com:email]

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

v7->v8: only context change - "return 0" became "return ret" for
        cdns_plat_pcie_probe()
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
index 8b12a46b5601..6fd16e09e244 100644
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
 
 	return ret;
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


