Return-Path: <linux-can+bounces-7273-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/RM+rSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7273-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC13349782
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FA4A3133CEC
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9538B7A9;
	Fri, 27 Mar 2026 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YJmPDJXQ"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587B38838D;
	Fri, 27 Mar 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637338; cv=fail; b=rX6GW5Oead35V6ffiL2sVSRMQP79Dh1aXg0/Ewv7ltX5ztZ/zCiDQabQic3xs8V6zdsM049pas8kA67lMh0ia5VTPp+SLM6npyY07vCGO5smBdAYu9EfyX89aucn/Ad5zn0KbnksY+hocCd5pZLfEqVCunQtFyUd6ZRQT/IX3wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637338; c=relaxed/simple;
	bh=3knv72qEMoSRBu8dyqgmv9FHC97Gvuc9xKXDWbJ8OTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NX4nLk840ze3ssCtZaB4jQ4DmPZ8STI72Lt9jPI5M0IrEFg5CPbWq6HfPb1Hd4Gkc8OlrMQWT4xB+D9FJrZvrK28LMBRx4hgyRKjgMT5UtEy2uHXN15Ub1pRcQCxywoqjJ5DvTKjVD9KUKIH7KreGYlhLziN32QtKRIklP6Aysg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YJmPDJXQ; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9uYpJuWjCw92EvolPZWCe6+fgu10ou02NRM7a2RV+IN9/hChKubShCIFX1VUHrs2z6IjrB55+P8mlsZSwPuQww6CJ7MHl2uMAmGGhXIDtbrOvTzs/7R0ZTdz9aOZnzXoRqbtK1o0KcnuBM7e7wZYGqX7ukRK2dF3YXARZFhExTJfBB+dkK1/OY36NWCtB8SWt/xlF03Bvtflv0bZ3g1e7oCn4AhllNwzRKoY1VxL3kOvTEvtleUANX5IJrA9QxLn3m66xlUcSupiNPCkkvcGvqou/FuL6bPRA8+sF2xne3RbX8DuKj6HtyyRdtVMXanjMgtjk+lmcSmju2RMCJHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUkwIfCup7g/hS5s64hg3B1Z9fNJr7FfPm5pRcEZ9tY=;
 b=pMtEfQhFqP6ZJ2KO/q5EdPBQwanVa1M3xUgsET+PvxVyUbhQSOagJJZFB4FKbvdttwzV6WOGiw2WcIe3scfsqTNV/IUjscD5V9yKLjaA9JlfegZUBooUFo3eH4onFwPY99WURyK8igEYRek7VcxN6wFw0lZ1uyJwncJK5JzrLX7KFYy3eFojKtLpZZpkKlZ5lxtCCcxeers5UkM24rRhiQhVxl+zjK5xS9LejWfLfO2/RISwUOyfTEF/Dg/unV4Yr9xNs+DsBWYxvfQNjU9v9g1W89Ian1zQxQBSqGqOwriEGDcv7tkkhXNeZDqcZKXrk9u0k16nuH5pq3PxqSARYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUkwIfCup7g/hS5s64hg3B1Z9fNJr7FfPm5pRcEZ9tY=;
 b=YJmPDJXQUog52O/NxWDAL/vDAB8V8gm/3UB/sDGe4YlTZ4TQghkfW/liKMysPNIZtCx/zxRNnJjKr9JJeJOdNp9UQPXm9ERyNBRmqzDl24Cx0fcbOuxqeHhungnltvYgYLCKW7WyPHNzjZZSl9e69lHH2kLywWsD43JccgobaJiUUCvQnmGWGZr3xWQgdYFF08b/yI2YQeJQZcS3P/Ypmg07MN9STyoTAkrTDKaZcVFHLwYLqzS1Qw/ZwvPu2fiUb0XbfCx+RA4BZXbhaqn48pJGK4XDlqnDqWQ4ibKzty4LriAUZSYAzz5sBq+ug1V6R/SXdZSzg6dDrIiZsNwkag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:49 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:49 +0000
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
Subject: [PATCH v6 phy-next 08/28] PCI: Remove device links to PHY
Date: Fri, 27 Mar 2026 20:46:46 +0200
Message-ID: <20260327184706.1600329-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 0246684a-5fac-400d-ef62-08de8c317be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	csj9CFEyZkWXge4t00y+91LSTMJMQ2APnc46sQiSPFlYADcOlP13CTZ8R2n3HDT/8UEkBSZL1kIEnCXmtUqDT9hlCGNP/6l08QqX55at1iJdsJcVn3mD7JjECpk7/vZ/G4/7r6cZphiHinHyus1ga11jhDFkresxu9DU+Cszu3PtA2qdYOCUsfQita6uuKIBsF3NSUjy4QGPLsKTKugmP3/jBuG9xNyG+fE4ChiIrFDUD5ba0XrOwxyZ2z7nIA7Ic25vwAOvbt80z8tXpQgqzznGoNLrwxVHOXQdUFHhIuyruY5WU0tc6sC9V0P95KuGBhVGInI7ZuBqvZrhdHbiltZnMYoPfofqUnbZcrmBZCtS3SOcaJYIC4MkGW4eKw3Pwyda5NIsyTy2UdrZKMEu/6/gIkX/yQjADHre/xEG6tLaJk5+mCPUiZheyYPEPxYuvM23PyF0Nz11eK6kHVl98/oqTp/u68AO1l1urAnl+1fX0eOWTRiClSeGX5dx6/92V8LM2ff22k58jLLe0sDLuC605qu86LUa8t1Q9jBnmKtCCbUMtqxHYZCQ9W5kYYmktFtRE3XChypfxedS2S/P3pIH7xJLnvxQ4yOXyTiRCCjaXpV1q1Mcnzo+vpIcYrBCS0JSl7NvrJs4sC2uuFRp3nHduXZ5ezQi/r+slGalRdBhhzOMsYW9iNi+kW5Q5Y6CbFVXAF2okoEiyXAdasiEZu46uougE91Lc255YBJuKKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGpSL1NUVHdDSHJ5NEM4QW1neWRTRk81d00xczlVRFZ1ZHhFRDZPSTdQbjN0?=
 =?utf-8?B?dWp4dDVxWHV3bVBtOXJSUERhWHFtN1U5T1M3RE5JQ2xzNUgvRnlXVHJaMTBU?=
 =?utf-8?B?UWIrZ3dBWUplVHozc3NWVWlMWGpLTFpacEQ5YTFTczNpUVZhenBzUnppRUNw?=
 =?utf-8?B?d0cxRWVrSXBheTRuOFlVbmVWc04zYlNsSFE1WGo0QmFINVdwSHNVUHVOaC9K?=
 =?utf-8?B?b1lxcUJpaysvQjVDZ1BRSTNSZUxrQTJWcG5JSGI2UXRQMjJrVzgzR0dGUkdw?=
 =?utf-8?B?RklLRVVJK1duR0tYUTk4SEVSTG1Wb1RaVkdyU0d4NHhtS25pUDYxK0Y1c2dB?=
 =?utf-8?B?MGJKYUcwbFViNmdJc2ExYy9MV2JISFhGeWpTeTc1QkJVNnNQUFVGYVZ4R3Jh?=
 =?utf-8?B?N2tZTkp0UU15THF5N201YzVVOUhKSHl0NUJYR2pHcGJ4K3plOFBlTWp6L05z?=
 =?utf-8?B?VEcyZW1HanNUbWJtQmg1WXpGdlVqUy9HdUJySTBSZUcrTVZzSTA1ODVkN0VP?=
 =?utf-8?B?eDlzWHZiZDBzMFNZNDVKM2xoUVBlelEwcUJVVThHWm1sRytkdWZVU1hOZUFP?=
 =?utf-8?B?SC9nNGt1WkdLNDMwKzd5SUx6TTdqV3VIKzNvRm50S3NVd3NJL2gxVXdTZTVq?=
 =?utf-8?B?TDYydjdHVDBkdmhkSmNhOE13b0JFczMrWTc0eXluUHBVRCtWR1VUMHdkZHFw?=
 =?utf-8?B?NUdkMU85RmhkZUVXd1lNdlo1OGhLTDZmM1hRZ2REb0UxNWkvdkRIZUZUcTQ2?=
 =?utf-8?B?VG1Ma2JZRHNFeTBDSEU0WFVmWmhLUzlwaEJOckxldm5MNndhazBERUpFS0oz?=
 =?utf-8?B?YkNjcW94UjNlUWNHRlZ1THA4d1FOSjUwSDFnRTJLRStibjNxbUhDYXRFemxI?=
 =?utf-8?B?eUFqMlFUclQ3a1pwb3Jpc2ZlM2dhQXdZeFpnUi9selVGRnhvaVpkSmRBd0dB?=
 =?utf-8?B?cFMrNDRwOXhsR2hrZzcyTjhuOTdXNnduSVpremNtZ1BYblFHK3c2cUxOdkU4?=
 =?utf-8?B?bDFCQ0N6eVhwTnNGR2lHYzRRUlZsUnhIa2RyMVdUeDBzVU1uNHlnWktId1ZF?=
 =?utf-8?B?Y0pFcEw3WGpxbEdmbkVqRmdpb2ZUNU50UnFuWmhYU0cyQlRIVm05UHhvcFhY?=
 =?utf-8?B?WExSRCtRekE3Mk9Xa2VvbXVHeVVjbW1GMEVveWliWEozMGVLQ2R2RC92YWF4?=
 =?utf-8?B?blFobWpzMG1KbDcrL0dyNHVweFMyenVnWENWY3ZqQnBJeCs5YVlZVjl6QTRV?=
 =?utf-8?B?TnlaeTRIT1c0M3BxWkNGRExLOXBaWGJRbXFKSjk3SkpXODFiQ3Nzdjd2UFgz?=
 =?utf-8?B?aEtwNkdwMElvMFFCOWNkLy9wWWtXSUthNGZlNXJlem1VaUtmUUNaVW9SYnZy?=
 =?utf-8?B?WHNsNUNFN3dYS2NWbzhKMDBiT2kwbWxzOVJNZ3M5ckJ0VlBHZTBHY2NncGpP?=
 =?utf-8?B?UGtuYXE4eWM0eDVDbTJta2phclJ1ZWhKOEZuWkZtSlB5SGNkMk1mR0NlQlpU?=
 =?utf-8?B?U1Q1ek9HSCtOY2h5SWFlamx0K3lGU3NWdU5ETlZnTG1yK1dnbUZGUk1WUXRH?=
 =?utf-8?B?bHBDMnYxRVQwTG5LOXM4ZlFKSVdVS3lXcTBCaWdGUUtheFI4a0xiUFMraWhQ?=
 =?utf-8?B?RVJEcXI4UnVZUStscGlwdHp2SmlwZ0oycFY0bUFmZEJKdUtRU0RrQ2hVcWV1?=
 =?utf-8?B?NkxjNWhNcWE4UThUWUE3UzZxTVFQWDZLZCtEeklpbnRjTWtGRm9jTW9lbERp?=
 =?utf-8?B?bThJNGpwbVRaSCtZNG9POFVoaXVNekJuOXEySnV4NlRZeGl6MDBiNjM2dTU1?=
 =?utf-8?B?eWhuL05aaWY4Rld3RG9seHN0QVUzMHpLT3NGOXlTSEgzdzY4cFFXZjBlRGVD?=
 =?utf-8?B?MndhamtKOHFKZHRYM0xYOUJHbXVtdHhFZGozZUFxVkhRVk8rSS9oZTBDUmhI?=
 =?utf-8?B?SkZjTzVFakUzd25yNWc3VGdkV0lRQWZzQ2o0Q2tyNjNQR01uRGFraDRWLzdu?=
 =?utf-8?B?ZmJyRnlYb1ZSV1lTdWdpUkNpcW4wWjBKNkM0RnhhYjdjL3VGNGRGMmtONEhj?=
 =?utf-8?B?RUEwanZvWUl0Y3dsd3dDc25lSEpLS21mUERQUXBoeUJaNFFMWUJGdURvSW04?=
 =?utf-8?B?NVZKdFU4OERtemJLZTNKRVIrdWVUekFhY2t5U3o0VVRWUSsyVnFURXpvdk9D?=
 =?utf-8?B?NmpJU1J5a2lxWGN5V2lBUmtjejdoT1E4TGNySjlnTE1GUUtkUC9aYkY2Y3g1?=
 =?utf-8?B?SGloZlBzeDZBaVFLTjFUYTJOSmMwZ2ZIOCtyMGp4OTdpSW9haEFWTzcyMC9J?=
 =?utf-8?B?Ynd5WjhLdkxIcEFKSzBVYXBTc05EdzNpcmpobzJMY1AzYTl5bENTTzVsSm1P?=
 =?utf-8?Q?4VOkNPjloZPQJoFjGYxDLiyf+EGl9s63OENlaIbfN3cjQ?=
X-MS-Exchange-AntiSpam-MessageData-1: rOcb49fJIbFr/+wUrOH09rroj97vGxPifUs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246684a-5fac-400d-ef62-08de8c317be1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:49.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jn+6paqi3Dc0A3oDylSnVvNOeW0UQbR82ReTiymt3ncNfhUp8F/+asZkfwInpb07fD6CeAyKBzuMhUyQie4q7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7273-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,ti.com:email]
X-Rspamd-Queue-Id: 3FC13349782
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
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

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


