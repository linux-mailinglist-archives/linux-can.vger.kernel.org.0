Return-Path: <linux-can+bounces-4383-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494CB3B3D5
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198E93B4E13
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D567261B94;
	Fri, 29 Aug 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGGAxBus"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C82586E8;
	Fri, 29 Aug 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451364; cv=fail; b=pqOQ/ZLs6HZaRM5vMMws1M3FDxfUayyjVXTCBgC30KyA6qvpLBzSX5Y7QddmWbuj+q7Kjkt7tXaHnjQ1cXoziy3XOSsQzriqDWQC2jzjf3o1bSEgtsWTLs41EZETVMfmh6AnfVZU7c6HHEegxr48b2QW81d8yPw3D5udW4BI4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451364; c=relaxed/simple;
	bh=M88aASUsQ5Hzbd3Bad+bBoZ+jo5LcftvFiM+D/s3irw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Vnhp+DzOUE4a9OnYkgO6mLOXtVmGbCCbLwdLZHlM10sMh59eLjP1ZlJ/3tz+65r/BS051lsny+jVIU4d1ab/V+SyCmSALiQH7C0r8Sj4Z43vuLvanvQj7Hjq6gOUcuRLVMBwCZiqZerxD9OWjqRUpX6docoUpyn49/ec5XMtPs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGGAxBus; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBGnVzOa9ZNJFV/qSL83EMXTTYa/vhRihanH+a/qFJyFo89BDVebK/NjHw5ldeqIePeMaEU1lLMqQvOnjx61V8mO4YIfZY308cZRHl0DElXvFyiVX9BlPHBcgMKqp0/MprsIhNY/2kiaiViiTRj89wbzeszh/zQHu+vPFbb4EsbdB6Qx0zqlk+Irci/hs1KW3XDydLmMuQ8sNgJ4Xm7H/kg2678FBN6SgOF3/NexdQvOTf+Ywoa1mpy24nWgNEs8QFyRU8+Wq9iTxDAaD82TJ1zEi4VgXafh1QGfKZn+lJIZya0UgVNU+9gD37R2oAMQxVgW+TX6VYdO6Z7X04kS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v5dJDf95lewCBTHDE5lOCnHvJsF3ssK0ZIKf9KmPmM=;
 b=YTor+wVA6KnY2jo8YwhMg+uD4QybkJA7Et/cZNM+SmkVzsvvA1WGYuIZvWJeDCO6kHZioUjx98ajFIxqUNhXdBTKc7YFU68AdkZgi4/X9J136XoPD03StniKbQq5RnLifnL2BXgPe1KVqpV6WC5MWBuSpc21/9ErEP05Ng1E4bfaEPesrwbMSjs9QZvAtQywbxGfLz1JDxcGhoCHRcI37rVf1BGkyhlWiOZrrHEfUhBgbsaiL3fX8PyTQiAEvXzknJP1FvS+apCN4ocgwjDRbRvcI0kXRYVACdoELWwHoqFnF3Eeo/0MpGcshyP39IiQEXJYEF8b6/5hxE2NfmW0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v5dJDf95lewCBTHDE5lOCnHvJsF3ssK0ZIKf9KmPmM=;
 b=ZGGAxBusPOrxVjoM+ulFsKiGlNfAdtS+zefg3sjMfqXstBf885UzHchr0e/fpiJPsiWrIG4eTYi4FVdb8Jcqy6TZhlwKTINNlJ2+ywW8eZavE6mVYCjzVfZpSySoz6J3g4a1w3+mn7kfUoSKP8YiUMd1bI0ZUkMyomXmfJPPLXq3CQ7KLv1MV27WhIc6EynmAhR/O2ntHZP7OfMETXdBHRocWgnMCBsiFoiKOY6xfEknxYhLlQW7s95c5KF11VimN0cG88ZBCe32TGVb4YeCaUCqp8iR/Que5lOH2u2bUSaN59L2ROHY6LZRUgv9YLTw6Xm9uKVOAqmUnJYojT+jsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Fri, 29 Aug
 2025 07:09:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:17 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/6] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Fri, 29 Aug 2025 15:08:55 +0800
Message-Id: <20250829-can-v3-0-3b2f34094f59@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdSsWgC/1WNQQ7CIBBFr9KwFgMD2OrKexgXMAXLwrYBQ2qa3
 l2oxuryT957M5Nog7eRnKqZBJt89EOfh9hVBDvd3yz1bd4EGCjWAKeoe4qNADTSMQGCZHIM1vl
 prVyueXc+PobwXKOJl+u/nzhl1EilNecK69ac+2nc43AvsQ8JG4msVq5moFurv2T5k+C3rd4GF
 EMeuD06NMjlZizL8gIkj1vb8AAAAA==
X-Change-ID: 20250821-can-c832cb4f0323
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=2061;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=M88aASUsQ5Hzbd3Bad+bBoZ+jo5LcftvFiM+D/s3irw=;
 b=xDJsyD9ifi4fg691MpYfLdkwHQXrNVpux0h9ulqRItOsn3Lh5ex/4mOancKQ1RcZoiLYkzkDG
 KyqDTVj6pAcBqFbrot19cujY04Rg5BoC+242wAVsv/+iAO8+mOk/SkQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cf33ed-b1d7-4e5d-81e6-08dde6caf7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlNVmg1QXhaZzN4QzNXcTNCSGI3MFA2aFJ0UHpuYzF0R1M1Nmk4TXY1VWhV?=
 =?utf-8?B?d3g3Ull6bEJCemQxcHRTMXJPVWFIN3VRbmNxY0RKdDZlaDRpT2tiYWZzNDRZ?=
 =?utf-8?B?UWNBMFNtbk42anJVWEdyRG8xalNZb1EwdjhEaDVpNmpGVW1lTDRCTzExTXB4?=
 =?utf-8?B?MFh6a01IdVNhRE1mTEk2MjBlSmh3NGdkVW85RzJBN2NPSGNDbncvaXBKZUQ2?=
 =?utf-8?B?VGNpY3VnYkloMFVYMy9JQnJrZTR2cUdRT3RCTFpGZDJjaXVjNU5wcDNWTDV0?=
 =?utf-8?B?SlhwZ1BySEZYZ3JXclE0am5Vakd4aWhlcjNOZzZyKzl5SUNjK1NYVnM3Sm1a?=
 =?utf-8?B?c09KQ082VUlYUTdWV01oejNoUE1VWmtjQ3U4SlIwQnFxNjQ0dTRRQTNtSlJD?=
 =?utf-8?B?TGZXUCtqSHhLcUhDd2lGcUpMV3ZwYlRDbTYrcDl0TUtNUmtETzA3ZUwrRy9O?=
 =?utf-8?B?ZlZWV0ljRWVRQy91UFd1NGdkdkVQbjNVNkxGcmNlZXhFR2RtNm5DejFGeExw?=
 =?utf-8?B?Q0Z6U01Mc1crUWZ3c0Fxc0FKSjE2bklqS0VxMzUvZ0xacjRmS3JZOTVYbkNs?=
 =?utf-8?B?b3JENitUSkZLVi8vUmRuYkMzdkVSbUI4cDVSOXAwbURFOGtKbzNRYTgrYTVh?=
 =?utf-8?B?UmF3bFpPNkFYbzFhTjk2eWtlcmNBSEdjL2s1NWdhcU9xVUpZN1c0eC82aXRP?=
 =?utf-8?B?dEtidlkrWHBqNWZVN1A1M2dKTWlEQ3N3RGxUanpwQnVTOTZhc2Q3dFA0eVJa?=
 =?utf-8?B?azlQT2RlUEt2aUQrQzFDVkw2T3NHdFNxMGdGSjZXamlUcW1ycHg4U3V1UVhn?=
 =?utf-8?B?azN5YTRPTGliVmhuUHlpKy90aXQ5Qld3QkNaSTEzZkI4elh1V0x3OWJmSGtp?=
 =?utf-8?B?ZG5zU0VVWFpLd3lHREZKM3ZjWGR4SVJ5cjZoRlJvUXVkaTF1bEp1V1JLa0U2?=
 =?utf-8?B?MGFwaUdyWURlV0s3VUVtam43QWtGTC9tSnJXdEVONjdTNFExKzg2SndxaUxo?=
 =?utf-8?B?N0Npb08zb3AraHlSeCtnWnVmcnp4OThtUFZpUFNkaUZxODVCVWdnSWZOYlJj?=
 =?utf-8?B?SVNvMjA1RVFETk1Wejc5MTh4d3hXZ2NyL2dNSGVZVC9hejlvUXVvVzYvSyt1?=
 =?utf-8?B?U0lxUXlsT2xhZ21TdkZ5aWtFU1BMMDNQVDdDcm4zZDdOMFlaL3NCOG9uM1Er?=
 =?utf-8?B?amhXRkdRZHdrM1FIQ2VYZGk5ZUQzZzFCMUo5cCtHZFJUWmhCVzdMQ2JpdnJq?=
 =?utf-8?B?eDJSTkxyU0lMeCtDYnM1M0VVYm5uVWlXa0NCS3MwZDM3VUdQdFppZmZpU3FT?=
 =?utf-8?B?UDRTMEYvTDNGYUhBY09zNHMzZ0w5NkRaL01Tc0J5UkJRRHpJczVFZXFta2Ni?=
 =?utf-8?B?UU5FSDBKQU1VSjZNR2VlQTJDdHlsUnB2eGJGcjhkS0ZsTmhPMTNFakw3anMv?=
 =?utf-8?B?cGdIWXcyV0cyc3FkYlZiaGE3OTRISTM0U0srVThuTkhVT010THBGTWl2Vmdj?=
 =?utf-8?B?UEE1clZpczMySW1CSHNLNFl1YW5VaktteHpsYVM4WlVRdS9XbGk4V05kUkJj?=
 =?utf-8?B?VXBybFFXbUpLbnJHZFJDL2pVTFM2SU1oaEVtMlMwam1BQUdxWGI4anF6N1Fx?=
 =?utf-8?B?OXcxVDRRQXNrdFRJZlFZdEhpVVdoRTQ2eFNVMkJRWml4R1lmeWtTRmhZRklX?=
 =?utf-8?B?WXdDSzk1c2pjRGFPUjhWY215Rm5VTkF3WkxlV2phMjFpMi9sSXNCSHJRTlc1?=
 =?utf-8?B?aDZ0bWtRRkVhSWtjZFQ3Tk1hSXZ2elRUaERreEFnTHM5cGVJcDhEbFZ0L3hv?=
 =?utf-8?B?VGx4dEg2UTFVNVUreW9ieFFnZ0tkNFROcWRabHlIZTFCckIyYnV3bVVLVHVB?=
 =?utf-8?B?L1hvTXowYTNpbjlhRXV5RDJ5VU44NmVhWVFnY1JxU3ZKR2Z6T1JaNm9YdmNn?=
 =?utf-8?B?V1VVempkVHhvTmZjYVJ3K1FlOVBXWjUzVzEwTERvNzNTU24rNGpBZk5XdDVo?=
 =?utf-8?B?V1hXSXpPdzB6VlR1Ly9uajkwdmUzTjI2MVNFVUhPZmFRR3pWTHBkR3kxQnlB?=
 =?utf-8?Q?AW0H5p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFMZk1Jb0c1ZG9DQTNwOXFXd2FnQmlyZFZMQjFLTFN0Nkp1Ty9MeE9NYnlh?=
 =?utf-8?B?MkZCazR4Yld1TExlTUtJdlBST2NtOFZIMUhKNXFiWm5UKzFPVjRibHVKbW52?=
 =?utf-8?B?eUZyeFB5OGZvMXhTb2tVeUJxaWRoRVZ4QXdJUVJld0xLV3NHV3QzM0VVT0Fu?=
 =?utf-8?B?NXREVzEyRmVqbElzcy9nUnlyTG9BS1JQTkpvNmlqYU9scjhmZzBjZCtWNFo2?=
 =?utf-8?B?VkpBUFFxRVNsY25zL3V6VzJrTG9keURvdEZJVkRSSU9TU0R6bXlrRklWYmlt?=
 =?utf-8?B?aE9uV0k5TTNZdFhlem5FMExQSzdZTzdEN2xDTE5pc1ZUZ1FZWXNOOExhL1NU?=
 =?utf-8?B?RTJJa1k5RldrZ0s1aEFFc056amJyeHduRSsrRzQzS1hiVDJQTEFubWpEUDJV?=
 =?utf-8?B?eUQvRFdZQUtxTmxlWUdvSE04ZUdvNXUrTE9hS0VTdVV1NlhHamJFUE5UZDFz?=
 =?utf-8?B?eXU2UjFhTkFURXlDdlNrekp3ZVFDaG8xRmM4TWRwUTUvNEZrVUpSaW9BSFB5?=
 =?utf-8?B?VkZUVXNRL0h6eGNtbnBzb0l5b0RZaVJIV1Fad1QzREg2OG9qOUtSSHR0VnNR?=
 =?utf-8?B?bC9iYXBJKzk2QnA0Ym55TFBlQlV5UnJhWkVDTnovekN4ckVZRjU2QmdEK0d0?=
 =?utf-8?B?RzdzWnJFRTNabE9MSE5udXZ1VTFQZExFK1U1OTF2Sk5QY1Qrb1hQczgrbjVL?=
 =?utf-8?B?VG1la2p1UDFaNFhmZ1Z4Q3NtK2M5ZHhjV2t0VUJOWkJJR1NPUnpESHpKZGlN?=
 =?utf-8?B?d3VuU2NyQ3FJRHhVV2pUdmd3eGs1ZU1JS0tTOGZnbERCeEFkOThuV0hhSCtN?=
 =?utf-8?B?Y0diS3piRVMwdzU5YnVpUk9ncVRqVGJOWDRJL3NoS1VNVW1aQ1Z6akEvd1ZU?=
 =?utf-8?B?dXk1NzJyeGI4NzV6SVNwZ0IwL0piNzBzWUN0eU1zMGw1Y1ZXL0lrNmlvSTBu?=
 =?utf-8?B?ZTdnZDBZZ2ROQVkvNll3U1NLMFJoblpUU2lqNVlEenpOL1kwYjc3SFQrYy8z?=
 =?utf-8?B?RlhER2pndFBaVjIyVld0dUhkVUhXdzdYQ1FRcXg0dVBQMXRVaytNdjlYNU1I?=
 =?utf-8?B?SURrUXpUWTI4K2xranhKY2RGYWJHQlZ0eVM4V3NNVTRIVCtuL0p1Q1NSSzVy?=
 =?utf-8?B?eEhwQjRLNFNIV0h3MkE4TU9QaDZKcDN2TWtCYXJkQUhMK1FNQ0tQQnVVZDRn?=
 =?utf-8?B?b20vdkthcTljbms4NU5DS3VDdUMwc0hvYkI5VWwyWWtwUFRoSnNhUk9QRjN4?=
 =?utf-8?B?WTd4Q1d2NzdaTXovT0lBTHJnYW5ieUthRUlFcnlzeHIyMXhEZUVyUWk5bUNC?=
 =?utf-8?B?SzBoV0d3L09xc2UxQXk3RXpDZXFJLzRIQ1paY3F5R3JFWWxwOCtvOUxzQS9n?=
 =?utf-8?B?cDY3ZW8yaXlHbkY2ZjMzeXlFK29Sc0tWWDhmV080azRTaTJ2N2tPWTJiQllr?=
 =?utf-8?B?VU5MWHdQbVp2MWVXOXdTd3Y4d01lLzVQaE94QkNhd0gveWZWMmNKdDR4YVdC?=
 =?utf-8?B?RllZTGVkZDgzUFA3Z1VNcEJGSnVyUmZ1QWtuS2xaZ2pWOUw3cERVYnhaUmlQ?=
 =?utf-8?B?MCtSQUQ3SDZLVlFHaHdzYnFmREhsNmZvL3NNRVAxVk9rTGpBKzVRWnNrZklY?=
 =?utf-8?B?SUtrUkd3bkphbldLNHlza2crSWlLZlZLdEpKWnFJTWVmL3M5N2RhclprbDMy?=
 =?utf-8?B?Q3VKWHhldnQ3empQbVN2QlRzZlFvam5ybUZqeWZrQ3F2R0s4TjZKOC81WGlT?=
 =?utf-8?B?aHVpT2VTV3RwRERORFdZZnhLajhSYkhFWGI3bTNuSkRMSGxZek9YRklvMk1r?=
 =?utf-8?B?d2hHbDdXZTRIcmpuOStGMVRQdVFsM1F3enhOY2lBbVRndmZXVGJ5eUlnMkVl?=
 =?utf-8?B?eklxZnp5d0pQVFB6ZWZiRkorKy9WV1dKcDJSVVEvQXhwU3FWRjRwUER0MGd6?=
 =?utf-8?B?b2FLNmV4RDBQKzN1c2puVHZHRUMxOTU0b1hHMi80TzlwRjdKc2s2aFloajNu?=
 =?utf-8?B?OU5aNml5OVdYamNMeXhqNTluazhPbmVVdUEwb2I3UXhSSEJBZnBFbXR6eVJz?=
 =?utf-8?B?SDhIRDFjQnRLZGlGQzJpSWJadTZOQ1NJKzdyN1ZmU2p3dTlhMWlHWWZtYnpL?=
 =?utf-8?Q?2C5sdDeTIvBJNrPDEo7ky1mLq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cf33ed-b1d7-4e5d-81e6-08dde6caf7ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:17.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXexmAJbe4fPBcpsRzXXUSwJVbLjzCPye0zv6v4ZC7Z0EenW3zImMCyTB+VOSTAzIrdN9kMoGKXirNi5TbFugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA1051 is a Single Channel can transceiver with Sleep mode supported.

To support them:
patch 1: add binding doc
patch 2/3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4,5,6: Update dts to use phys

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
---
Changes in v3:
- Patch 1: Add TJA1057, update #phy-cells
- Patch 2,3: Separate patch 2 into two patches per Frank, 1st introduce
  can_transceiver_priv, 2nd support dual chan by adding num_ch
- Patch 6: Change to 5Mbps rate
- Patch 4,5: Add R-b from Frank
- Link to v2: https://lore.kernel.org/r/20250825-can-v2-0-c461e9fcbc14@nxp.com

Changes in v2:
- Update standby-gpios constraints per Conor's comments
- Drop patch 2 which is not needed.
- Link to v1: https://lore.kernel.org/r/20250822-can-v1-0-c075f702adea@nxp.com

---
Peng Fan (6):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      phy: phy-can-transceiver: Introduce can_transceiver_priv
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  32 +++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 +++-----
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 ++-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 ++-
 drivers/phy/phy-can-transceiver.c                  | 120 +++++++++++++++------
 5 files changed, 143 insertions(+), 82 deletions(-)
---
base-commit: 47e2059d930288d2225941bd30cc3fa1fe348044
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


