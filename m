Return-Path: <linux-can+bounces-2218-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520729D8AF0
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 18:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C83B38ED4
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCB1B6D0E;
	Mon, 25 Nov 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KHKsEm7z"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41F1B6CE6;
	Mon, 25 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552280; cv=fail; b=S3ooSdYG+P6GfF09afqy5BecGyGXWKdAkUDdEKszPn0Gw9+TpU+iVdDUC9YG2YTvOX2qIc+wwP+UWtzCycPU3hHpbXxair0VMGnjyjQFR++jHUSOF+VeofaYBWxum0RfnbY4RIAtcfCc+76G+b14A9PfutooQwnE8EBaq9RvKwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552280; c=relaxed/simple;
	bh=MYMujGZAYq06JYtN7KHj1um7TxlB9N7/uwFx+yJiAxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brL0jwGAxLejHsgEZJJtJPd8YiFiAq2XX4Fj19CiDyeCeKIaF30P4u8OKDzyLMUCd1mck9oa5iOlpyel3C3wlIYbQxMzMdEQhraVqidhQJCFzfJvnhsV7fK1/TGvlQZnvltoKSk6vU2CHl/l/77xx3QJAiYFKISP9+48kkEzEho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KHKsEm7z; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjO4W2XrO05r24ssVX4H0zY0KZE8cyj8x1no8LuPK3YIhEHXtqFXjukl3L2qkR3Bm4h7aFJMKdaXfg5kxokoBEP8wKidMIasM0ncs/5zhXv/8KrvehFOGmpda0oh+++Bi7TzRfTUvRmfL6ZPcT6obAQEwO9Sv/HuMv3658SpsPchb6koCCdxyHNTaYSFFzGJToFMfSvJTO6QRXm4XA46tRK2vgP+VMYgG6agk/vYVrwHtufBR+Fa88CIAAyYEbdO3q55LOJ6FYwEJqS8Dxr7J7cB1LAdNV0HEs5ejFJPJZsdjHb0HH/jYRvh4xEaL+RcwdMyEZjqcwS4xCZEKO+9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9zGiLxzpZ/vmJvSks/LGv0YsCMZl3nvZjTEgtwWwC8=;
 b=K3QXazmguy062YHgguSfosuX+ra+mj1cEp0zK+9GoTJn/3LQQRInq2oMwZRc3lGOThArCSULwjh1st2sTA7aVomGMEjE/8wCMM8s/wJ/cbEziE15/wuE4itNNq7zsuwrC9JWPHUdtRvLpV88uhHZMCqjEpfh0HWjLtsqwexMnI2Cvu4drnzJxnI8Rbusd4FxfIYEL5wzo9xnAqQNCupMOWYFDDlFbBpWqYTTC15AXdPy2Vr5LKKO4HrYE29AY6jfuMSYwkSjJ6JhmMP4EVhn7lmql69yp5Lfvwpl2EGrrOiip0+kjngZnHyp6w0PuJQkZs5g6YO5VOXeOPeNq6wD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9zGiLxzpZ/vmJvSks/LGv0YsCMZl3nvZjTEgtwWwC8=;
 b=KHKsEm7z5dCmIqUjNKqq8I+IV3Thn3d3P/B3Zf+CE4eUTUKVc2kJ595R/hjmRGYNZ+Q+4gMJTUdG/QZl+hE2lABmqqW6Lp6e0TbSATtFc/A7WR6HaN2SyExQ/+VI0Mo2RqOHgQyx3qnwiEDSFFymQg7UUmf/XEXtqaCIkqI5hS84ctCL3Au3QJG+IKwWKwsvBKrxvKH2XxKMjG2FDWDl+CzLK6//xpdbO6HBerPJBt3pT0I96uYKueW3eAiml+vVHoHRdxTGfCxRepESiRm0q78Ew8LPuVQ0QSiea5DQTCCbU8YrtdO1o0yeDw24pEXVGbCLMg9sDWS+QOaUKzS6zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 16:31:13 +0000
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb]) by AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:31:13 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Mon, 25 Nov 2024 18:31:02 +0200
Message-ID: <20241125163103.4166207-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::10) To AS1PR04MB9261.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f741b7f1-dd53-4079-860c-08dd0d6e93a7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGtuY1Z5UlFZaUNGUUxONDlOQ2lZUW9ZOWx1SXMzQVdCQ1dRMmQxaVNldDlX?=
 =?utf-8?B?Qnl6VWVkL0lZQ1djc21ncDRPazVGS0NjQzZlQnlBd2pwcU81MFdiMmpCcDly?=
 =?utf-8?B?Z2ZsUElDWEMyTGkyOXBORXRQajJrWEkrcUZPR0NveU1zM3kydzhPQmtXdExZ?=
 =?utf-8?B?L0NXNWFvbTJEN2lVcDlObk1kQ25jY1MvVXJ4Y0FIQnVraCtHYk1OcWZubk5R?=
 =?utf-8?B?TVFWcXR1cFRVTWtuVWI2dTh2Z0s5OEIwREpQSWVxNm1uMUpvK0gwZDdtWjZv?=
 =?utf-8?B?RzlrN2syQjlQQXhHejF4VlFjeTFkZ1c5eVpRSWsvTXpTWSszVmhMSWx6VkNJ?=
 =?utf-8?B?ZnBPbVJrdGhtTm96ZmY5K1RTdmVUblMybkhUYloxSHdIVk9UTTZhbldJcDBZ?=
 =?utf-8?B?K1daWmtOZUF6QlJ5Q1BvdENrVkU0aHZHRUNHd0xuUmM5SmJIbGV6Ulp6bGxY?=
 =?utf-8?B?dW1jNWcrbFd2ZVFHYitHVHpMRGdRZk1UT0JsOGNOalBlYm02d3k1encyaXdy?=
 =?utf-8?B?NFQ5QkZxQllDZExVMDAybmZqanREdU0wZVNwRWt4UTVwRzZJTGt4QmVKWmMz?=
 =?utf-8?B?MFZENTMxZXg2UGhqQlN0a1FEcTlPM09tR0ppNmhteEhDYWdWU1cxZG93MHZi?=
 =?utf-8?B?QzdINTBEenA1Z0d5Z0w5a3hvRjlzWmx3NW05K0t3eFMrUUxuUTN1NGttVFUz?=
 =?utf-8?B?cXVHU004L1Y0Z3FVSWZxNHo0NHpXTXlsUlRBdDFhbnF3Z21rcE0yWUluZk4y?=
 =?utf-8?B?R3RNcno4bGxHcGEreS9nL3dYMjJFRm8zaUg4ZmFxeUIzcDdYcXdUMXdkTHJH?=
 =?utf-8?B?Yk01Q0VLMXJrRGphMVNIbEU5NTQ5QlN3b0ZpQjMwMlNQaTVNejVMdXVZZ3o3?=
 =?utf-8?B?bHl1Y1k4WjlSVktidkp5bW02QjFNUEs0dXpqcTh5cE93a203ZFh1WU1TbFZQ?=
 =?utf-8?B?UzVFa0dQYzBEc01HaGkyRG1DYXUyUW1UcGQyS1dZbGhqcTl4NnZ5Q3kwY0t5?=
 =?utf-8?B?TnptTzlzbW5rdkVhNEhQQkJnaDlBR3preTdWb1Q0QWxVSGlnU2xBY1k1cms5?=
 =?utf-8?B?YjI5RjZ4Qnc3YTRrOVNUUjdlRmFhaDRyL3RSanhiMjdYOWZOVlhQN21qVlB5?=
 =?utf-8?B?S3p3bGh2b1QxYUs2WHZkWmNYUlprM1hEbDRWOFRGK3lRdmpVV2pRVGVzUWpN?=
 =?utf-8?B?bWQ5RHBCVG9ndTJHQ0lncEhwR0VHaWJTRXV5b0todmJQakhaR2hjanhmemJp?=
 =?utf-8?B?SEM4TGRVakpKV1hnMFBOTWdodXltOEpiZnNRQjBIQzJScTA4VXRjdENjb3dl?=
 =?utf-8?B?cTYwMnd4Y2R3ckdwUVpSdlk3N3dLaGZaL0Z6aW15Mkh3cHhxYm5yTXRlODlD?=
 =?utf-8?B?N0VSRzZJaXZKR0FXcXdKbVQzTEw0Zkt3SzZoYmZSRE5SNHR4SGVvMy9EQVVx?=
 =?utf-8?B?VjBETjVvcXRvVDBQVXg3bWpjNHVXRExHZmxpVHNPNEFBbExOeTVEc1YzazVI?=
 =?utf-8?B?dld6ZUhUdm4xYUx3K3NsV0RlOWpJcTRveTRCcHkyVkNGNzVEQXdQcDZoYVJQ?=
 =?utf-8?B?bkhTc0t6ZHkwVzM0VldaQ3lSYTl5b2hGdk90ajU5YWlzdEQycm5sVGxUTkZO?=
 =?utf-8?B?eHpUdHUrOFNXbGpUelhtbVNVMERqdkNFM2pUSFBNdXFOT2pVd3RIK3FzVnls?=
 =?utf-8?B?ZnpFN3R1SDNrVnV4VmZsRVJlaFQyNTBHUkpkbk1nWjhQUFJSdGgzdDEwYXZn?=
 =?utf-8?B?a3A1Q2d6VStRRzQvQWlseXR0M2UzRFBjTVlka2drdzdHTmw1dG1DQUphQWRs?=
 =?utf-8?B?VEdKRWcwZnU2eDBNTWQxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9261.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OS9aM3BBS0c0Wm84SzFGelBQbWk5RkxCSXUyQUVZVVMxT0VDM0Y5TE1nbTZB?=
 =?utf-8?B?bXBDbWh5N0pXY3BIdGtZQnVBa1JKMklYdTlmS0lIR1JJUmNaVUI0RFk0bDdL?=
 =?utf-8?B?OEoyRXhnWFUrQjhYSkNoVWlBd0VwaW1UdDNaaUw2alNFeEU2TSs4ei9yZDI1?=
 =?utf-8?B?TkxSdmRZdyt6SmZ4ckt6bThUQUJLQ2o3azlDL0J4TWR2QW50b3ZTNmtLc1hU?=
 =?utf-8?B?VldyKys5NUxMdGVvSVR2alNNU3RUOFV2dDJha2t2bHlEQzF3ak45VG5TU2FB?=
 =?utf-8?B?T0xkZ2MrNWQ4cDgyT1pIT1YvQkREM29GOHlpNTdJT1B5bElDR1A0cDdRVFJQ?=
 =?utf-8?B?OE8rN2daSGlNeVJiZG1VK0o4czI5cXdmWlg1KzF5eVdVajEzdGRJb3A3VTVp?=
 =?utf-8?B?TGtjZzJSUjBkeTlZUUc1Qkh3cmZ6ZldKUUw5REt5SmhkMjBESjJHdFZzaWhz?=
 =?utf-8?B?YWdoRlRrZEdHOWlSaHRUSmFRQnR1QmlybU9DUzU0ZXJycWFCWWdCYytMdmpP?=
 =?utf-8?B?SmdhUzl3djFaWEM3dSs0bDBBbzZKWkRUTGRWQWo2L21OckpzRzZXOG1RNnhv?=
 =?utf-8?B?bFloV3BUdDZteFR4VWxaVkhldWszcUNsazVNYW9vZDZhb2lhZ0YxcmQ0dTZF?=
 =?utf-8?B?NDlqWmVaelhWaVF0enBRaUYwYUI0dzJPMjg0M0ZQdW5YQ0ttRWdZRmVrcEdN?=
 =?utf-8?B?UldSVXRPT01NQnhlQ3hURTE5ZWEzY1VIYkxIallubmQ2MmkvNmxqZG9LYjZX?=
 =?utf-8?B?bGwrTnFLVFlYRjJ6Yk95aVZ0N0VwM3JSL3pRazZsWDBrTUJzeHNuV0w5UTEx?=
 =?utf-8?B?UUlyaHYzY0o4LzlEQW5JUUNYMldXbFpWME5TMFlsaTVpUTZPbXBOZmV2bmE5?=
 =?utf-8?B?SUNjbkh5dDNqVXJ6czQza05jb1BxTTBMU242VGFmOW1SYmIreXB6SWFLQW81?=
 =?utf-8?B?d2NLSWRVdnV6M2pOcHRYM2NyaGUzdFZDbkp6WFdEcWt6UjhFZkRzZ0J4QTJB?=
 =?utf-8?B?MFJXa1JjdUlBY3ltTUVRQ0hQdHV2c295YjhjaHlCYVpndGFWejBkMnJyWlV3?=
 =?utf-8?B?L2lQMWk4bWFaWWwwZDRVSy9rR2hNUVdSUkpZUkZqZ0c5aUlHWklmSnZDVUZ4?=
 =?utf-8?B?eHpIMFUvNU94c2N0alBiRjRxdmJ2aUk1MGJXZWJLOS9OcTFPZUQ5YjF3U25h?=
 =?utf-8?B?Q0RJK1dnTG1GNXZBS0gyM2YyL2JwbURTNmxBVHNLQWZqcllJcndSdVpqZDVx?=
 =?utf-8?B?Lzd5NzQxUmNCOC9TaUpCWDRZRC9sd1RER0llUzRIQ2VpeFIzbSt3YjlNb0FW?=
 =?utf-8?B?Um5sZkNUOUMyK0x0cGFlM05jSkp1N1F1dElORUZPU3huNFR0WDAxd2N0T3lO?=
 =?utf-8?B?WlZ4elo3MG10aFVZM1pyMTBVTDlkalE0YkRNb21hQitjaUVIWG96d1J6SmJ3?=
 =?utf-8?B?VG5xQzd3VVVTVUNjakVkSGQwc0E3aEppWHRKVjJ2RUJXTHQvR3RPOHFLNUdH?=
 =?utf-8?B?L3FBSCtzWEFDa2xFNGRaOWNWVm5ibzJDL0JpWDRvN1M0UG9LV20xek94MFQy?=
 =?utf-8?B?M3ByRXB6SGxCSlYwa1pkQjVIWHJ5V1JpZnhNSzFVRnlDODh2RzQ2L24raEVV?=
 =?utf-8?B?ZTc1NkVBYlNXQ2YzaDV4OU9VcjdEUmd5eU1xdkNVeDJ0WHcwVlFTeldSZmlr?=
 =?utf-8?B?d0lEQ3g4TUxRcGZtcVNvZzRjM24zUERjUkhubnZGYzZpVXY5V1lyWCtIT1Bi?=
 =?utf-8?B?aG5ycnlQZ0tNNmVFcXlvdEJaNTZldCtsK2NuQmRTSzVVS3lXb1JoNVVuaVEv?=
 =?utf-8?B?UnEvTVJJeXJWZFp1MThCZG90MTFkRHdtTGw5cTFRMWhQNGQyMzhKSzJZcTFS?=
 =?utf-8?B?Z0R5Z1ZVazJiY0J6UVRGSWJ0WTgrUUx4Tk13KzZHYTQvYUh5d0VzQzFNNmYr?=
 =?utf-8?B?bHp6NTB1enlibTBQM0R6YVlpZXpoT3dCV3VHZ2VvbUppTGVtbGF3MlhkY1Rt?=
 =?utf-8?B?S2RTOXhUYmo5TlV1UlAzeUh3OEg2eU1iWnJJaUR6TDBMQ1ZlbXc0U1ZXbDg1?=
 =?utf-8?B?L0IwK0JQa0JYamJKSldGeC9IUm5OdmVBcmJiWVUzRFZSRUpTTDlFekRRVW1p?=
 =?utf-8?B?bDBxbDk1S212R0hyMjE1TUFFaTk3SUJCS0FLOS9KRDZpZkpCT2h6RHl5WlNE?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f741b7f1-dd53-4079-860c-08dd0d6e93a7
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9261.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:31:13.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtz5gSLZyoGHJu3OBGDEQjAdeAgRktnk1hRskPTeCZS9OtG+pfHWhdjfSAkdBXyvcxRM+CYv5VfgZRWQMFkiOzqr4vgZ15u6KY8AOJmbdBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different.

On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
In order to handle this FlexCAN hardware particularity, first reuse the
'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
support. Secondly, use the newly introduced
'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
separate mailbox ranges are controlled by independent hardware interrupt
lines.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7d7f3fa1d67b..bb24ae6195f9 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2055,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2


