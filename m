Return-Path: <linux-can+bounces-7111-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL46Cr3euWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7111-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051972B39CE
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F982301DF73
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E63FB7F4;
	Tue, 17 Mar 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cwn4DMXh"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE643F9F46;
	Tue, 17 Mar 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788756; cv=fail; b=dDZdyy1xp2r6/6U5jVynfk2TuXKOIHFbtawDxR17SS2gs96czt1QXpAQyAINCD/DfqFf9cHR313M6UUSbXTcSfV9JCL/z5Fd8F/cnC22L8X2bq7cY4XlB6x2NF4VHMCeESmIYYkHoxATPyLMPX/RNFShpQjy0K16BaycV2Z/omc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788756; c=relaxed/simple;
	bh=6NMU/SRrhXE/MiL6JHSCNEjH8NOC7WS2T3Jyi9wd6Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5wT/jP95/ST+mzAfT9LT5Vn9AVVPQKH7QPMpV6KX7TO3AsMLf8LZydZI4PikCJiEzr02Aiv/1LrFD8EuErs6s4dVQmp+jQvvR2Z8T1LYVtymPBesBQyNEu0E/YHTIjxPT37aXmHblhnkcnteJghq2fXPRFXRmoC7LcQQ9Elvks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cwn4DMXh; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgjaNVdqYTJ1kYQd8cH6dYNVVqFyRMJuYkOBlmwsaFXgxtrnaIkYFRVw9b5ZBG0yR39dqMHRopCVVEM909zCjoZI8BY0pQ64Ho4w1Pq9YayrkFaLF81zFs34ByITtusAB/PO+kwO9mwdGqLnc9akvr/Qmpncc1cjQ16l21EtEGj6OYrLctj8Qq1Y+E8TuwWCRkcqy1YqenSEorWnG6+eW1bZGlFTSnZ4J32wEeFHT21RwGCuLgJe01hfGu4FgnuxL3J/C3/Gc0O0dVgI2o9v2Pk8MPpk35T7CwN+4YG5n5FZErhrLdauY3ebTwVrMgs8roxBGrloJFMlCWsVHq/7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoRmlaBKq/HTgxcz7UdBU/a6FayMfH+6d7e1R8P1Rbs=;
 b=oh1s3nfPQMxukZnWudTsWSdfnnVTzG3TD49Vv7tEbtf4ijfItUnWPAH/Ujl8TUaDFbeIT/aqVr5tLsKQG64oK/2DulQS/RN5EYesX/oBUaMq9PRtwNO1Twn5xJ/X0d4ZqhokWh2+6PgOQ9i47VhCbOMeLsJry2LKVwJ/eZwCFcjgrOe+jcD25RBIQ1rlGd7JvllUwuSPP5g9U3531r2GlZz5ohRcG8U+ZZbu45053JjFfN1ylWPfjf5Rat07ZTqusqvQhPCWI6X4tMT1/J9i5NjIdbnsDFrjyadf723iCfCRscnWNmApVudwLolJfN6l6+QOtErl1AmoAU/TlSpnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoRmlaBKq/HTgxcz7UdBU/a6FayMfH+6d7e1R8P1Rbs=;
 b=Cwn4DMXhNya4QmdjF83P88UHVSajJah9Xu7r6cxxpFjBAolHqxPgALr0wPn3yhEeRM4DXOwk+sNUU5fYlWH8bKJrbryNRcVWYkqVYpwwCrbNV+LXDRJTj6mb6ic2+Q8bOU3jPTEx0pTBuGNGrpmtPp/qp4CiNHPoXxvTV5Xnm04/+vcv8j4TLYNgQSEHqrmSNOGdlHVjD6Hpnbssp7sXWNkjKToqiJ+gxclfFKWQ595vDbTxZ4Fptmmzb7f+NHAQEeAZqsJ84gIjbB1p/CLO+3BqnXY/sn6WXsIVjRz/LyPeYuTHSqGlQYzu8eZRyfh5zA/tSfLleEyKz1hQZUxiXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:27 +0000
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
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v4 phy-next 08/24] PCI: Remove device links to PHY
Date: Wed, 18 Mar 2026 01:04:44 +0200
Message-ID: <20260317230500.2056077-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f4548c-169b-4db6-25ee-08de8479ad98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XaTTd6/QTujM+hP53P61rUv/YaYJUA7q+4Wd1V+TGRoE++uCoDDk6uScEuYTjGefTiH0q1EfLetVp3H+C1lWPG06L7cbsA6kD9tlYV+cITLBTNkgH1JJeGlSDDslHhVnlO41aD0JzYMyCYWU7YNGS2Z4/NP3mxLtR8UlKVp7KS7z3fxoSQqwpZPMs1Se/O4izIt8Hxxxcp2EepooJfhjhRZGfLg8w+AapyunobGwQscCsfg2sat8agr1H7H16dBVBIjatc1LnwWnYkipeoJ4KjZM7BcY/h3rPAlqNcvyKzNL+9uHHqNV95xz63QizpVQXoqMGXIabVwUnWUdh+YEffiLAZylx0trPK/0zSEpunyJIQ75chjYPDwDUg4XEbTBOtL9xYY4a5WI8VU3q0UkLRJHPhMECb8lQfPnx6qA8DAxw3Qpx9U96V+BCAUorW5h8rH8Hmqhx7n8lfbcrrcpHf0hAJUzykpmRkVWRY8FoPze5xChONJlXH3B+ollviUA4nnN1wNRulzZuoTVGSusTKu0eG5+YQiUjnhBXW+T1VMOqUDdK+wUanHlUiU60nVdDmvSchI8fvlOEfY1+9Jaf2yQldTqKmPnmRSJXd+FtG7WzJcLvNoV95/r+w50/LFMiMNQ+AhmogXWgWFciql0SQunfalgPDooS6ZlKa4eUUpZLH0F1tOxQUL6QUXwfK+UnxGbUfXX4bvPyLfmlSmLZnqa6VLV/vSvhLLfoENtOSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjVEODdkcUZHR2pBM0tKOE9VZWJ0L2pKS2ZiNzVxQll4NDZqZ3lqc3hxWVhl?=
 =?utf-8?B?K0dLMFZhZWJZUFdIK3BJVzI2QmVZUlVwNmRYWm5IQkU1SkpPbkFsRTk2L3BE?=
 =?utf-8?B?bDU2Y0tScTdEbi83S2JzdFdMZWsxTWF4UTNkK3FYY0pPU1BBblFQNnllUjJS?=
 =?utf-8?B?STFjMlVGbU9PbjI0OW50eUd1R1BtR050ZkNCdS9hUlpEYSsrM25PRGtWQWVn?=
 =?utf-8?B?dVNwV24wUE1XT3FScVJ0R0tBekx1WTc2d1lXTThqZGFuNUxSaUw2dktCcjho?=
 =?utf-8?B?RVUzczFPMDYrTmIvZGJDaGVteERUQ0VtcnYvRVAyY3dKYmdNY2pxYzNTTEdn?=
 =?utf-8?B?UlV4dHBnOWZuRW9CUEd2ODJOSHlqVFJhUGYxYnJpblFQMHZnc1BjNXBkTG9Y?=
 =?utf-8?B?alpvMDE5Wk91dGtodnBzR25HTUh1UyszRUQ5TWdTMlFPN0gwYURIQzVabitD?=
 =?utf-8?B?dGhXYTVWTWRBeHZyRnRkTTdubUt2UkRwYjJkMmRoN2p1MXdod0FudmdhMnNW?=
 =?utf-8?B?SXMzMEVQTFVRVEhpMHlTd2tGVVlRTzRKWGZBakxHazhCY0FPVXNXNmN5dUEx?=
 =?utf-8?B?WTU3dEVDSVpEc2srTDZuVm9HVnZvUkpLcVk2bTZSY3ljZ2hoQmpkN3pFdG9Q?=
 =?utf-8?B?UW5xa0tIRDhTazVNK2FmSFh1UmpscVFTcmY2WnZoMm90VERFdGZEUUxDalRQ?=
 =?utf-8?B?OEpIWjRMeXRBeEdIamVHaDV6cldWbjJldDRvWk4zMEsxc1BJbmpzeDg0b3Ra?=
 =?utf-8?B?VUF1dzdXR2VXbmU0elVFWFJyK0JwWUI0S0ErSzIzR29tMVE3Q280dkc0dzll?=
 =?utf-8?B?c3JZR0lCdWFLMkJGUDFWZGhzSnVxNGd2L0JGYmUxVy94SzNtdUtRazdUQkw4?=
 =?utf-8?B?TEZxUERLQXdkc25EQWZPWDVWYWNTNkQwaVZ2WlBTNXJ3WkdKeFgzRlNWb25n?=
 =?utf-8?B?R1ZZZ2ZXa0Z5VmhhMUxYNUgvWmlzS2ZkU2p0VW5OdDFZQWVhUDJYRXNORW1x?=
 =?utf-8?B?MXpZZno3QzN6dlJQc2w0RFRxRlBWclk0Wi9SUnovZG9HVGFydGNySU11OEla?=
 =?utf-8?B?emlCamVVc0lFZ1EyUEpJaXBhbFlFWVhUcWJDdVl1aHE2UGNJa2hvK3J5K2p1?=
 =?utf-8?B?azJlaWZIbTNWK0oxOG15VjBBV2txZHd2UUZqNVJUdHl0TzV0UmlzR1QrWFlh?=
 =?utf-8?B?RmVDenFEMVJGaDd6eEs4TjJhYW5vZ0NyTWpZeGRiTGdJY2tOenhuZ2ZWMmxh?=
 =?utf-8?B?WTFyM1lBanc5S0tMRnAxUlNrVWNrclY5bGdBaEsrK2pWWWVsZEpWaFluMEZW?=
 =?utf-8?B?Rk9WcVo2NXRKS1NlNkJJblFPekFoVEpkRGVCT2xiZGJyck1TNGpiYVF5UEpm?=
 =?utf-8?B?NGpvYmMwMUt0MnpKZE5lMllvRHFKZkdxOXo2OGc4L21hZ2Q2U2xFOGNsSGxN?=
 =?utf-8?B?bnBMbmN5UVdwYjI2bWVkaStqSjVKaFFwM05DYjNsUnZRTG9tRUMwMTY5aENZ?=
 =?utf-8?B?QnIybkJ6bVlmdFR5MjljN3NEZCtBTjQrVDYvOVZZWjBxaUIyMUtmTXBkcjVL?=
 =?utf-8?B?L01xdisyODM5RGpPeU5JVWt1RG5iZnJCdGZvbTY2VmUxR2tYeGtUUTZxMFRo?=
 =?utf-8?B?YzNEVHdydU1Ic3JER0ZFazBtQVk4RTByNmNUcHEvZzd2aDN6aVBPNGI5ZnNY?=
 =?utf-8?B?M29DUFpaQmtmR1FhZ2lldzVPcEp2emZYNmgvV1RMR2JmOHU0MnAvQXdybGZq?=
 =?utf-8?B?MXgyczlwZGk5dE1UQStpV3ExS09jVWo3OUhyaDRNeTJjOUlGdWEvcGVQQW04?=
 =?utf-8?B?R1R1VFM3VFRNWE0wWmFXZHFHQS9uSkFDdC93QWtWL202b1hhUU02cnRCZitE?=
 =?utf-8?B?dnB5RXJsdU1IYmg3Z1lLMzJIdEtHNGZqV0x5b1hoZTlNdUpUQVl4NzdCQVUv?=
 =?utf-8?B?amJmd0hqeEJJSUFncEhLRHlGMmxRNk04OTI0MG1LUUxlYzluSE9aQnFlU2k5?=
 =?utf-8?B?UUZrOTAwc29qNHVYVThicnlLZSt3Y3Fwa0FUcWYzUzlMcGJsMTRURi9OLytN?=
 =?utf-8?B?MFJ6SVB6TGdjRFQ1THJoRDF2eDdNU2k3WmpGZ0FNRENTZlJ2NXVUcnFDbk56?=
 =?utf-8?B?RGtmdC9pZFZnSGcyZ1hLUjhNeW03SmFzY0VhQ0tEZ3F0M1lzK2xGN0x3UXc5?=
 =?utf-8?B?RUxiVVh5V3l0SnVlbG1aSzRxMVlxdXZEd2ExWnhHUXdHSllJSzBhR1dJVlY3?=
 =?utf-8?B?ZUptaDdVWVpRQ0dBZDBtZ0J2OXVPU09qek5uejFPWHNXWEVPTm52ajBqTWFk?=
 =?utf-8?B?dTc5bzNGcU1oSmxHWnFtM3pxMVExQWhjaW55Z29XM3YzK01TaUxxWE43dGxG?=
 =?utf-8?Q?nvIUbXYXkYUp97AIhOt4V+laXCr8nepFvLPM/EKvUEeRn?=
X-MS-Exchange-AntiSpam-MessageData-1: HJhtuuIyKarmlGxGQV4QLVjq9Pr5YJtMzlI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4548c-169b-4db6-25ee-08de8479ad98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:27.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7H/BIM5Ty+Xdbq88DoSugEXL7KR8cOnHmBmHTDHrmjFViXwskamPyGlOIWPQE0WYJ5axJWNbdtHrddUm00l1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7111-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 051972B39CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

v3->v4: none
v2->v3:
- remove dangling set but unused phy_count local variable in
  cdns_plat_pcie_probe()
v1->v2:
- fully remove struct device link **link from struct cdns_pcie and from
  cdns_plat_pcie_probe() error path
- collect tag
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
index 443033c607d7..35b0b33bc6fb 100644
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
index d5d26229063f..b91ab37845c9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -683,7 +682,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
@@ -731,10 +729,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	dra7xx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
@@ -749,12 +743,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
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
@@ -856,10 +844,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-err_link:
-	while (--i >= 0)
-		device_link_del(link[i]);
-
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 642e4c45eefc..07698c645e02 100644
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
@@ -1118,7 +1117,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1189,31 +1187,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
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
 
@@ -1223,7 +1207,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1238,7 +1222,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1325,25 +1309,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
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
2.43.0


