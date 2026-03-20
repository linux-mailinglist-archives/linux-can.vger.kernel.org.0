Return-Path: <linux-can+bounces-7196-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM/aOO6svGnz1wIAu9opvQ
	(envelope-from <linux-can+bounces-7196-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 03:11:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49322D507D
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 03:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A90E301DEEE
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF131E855;
	Fri, 20 Mar 2026 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r91JeBFa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ibSuhE/b"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095C2C21E8;
	Fri, 20 Mar 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972710; cv=fail; b=rBZd9gYkOrjYVHDktto5dbA1jKNMhJHYdhyzPC2kjWc/TpBFhjZJZG743M6UCNKOwG3qA1Qtk9P3HAiExg9zB0WJQ20DIhiSoaa+dTbUEDpUjfDQzczyv2GxooN/RKkD0+nhb4TF/EEwXnuiHy/FY90KIEt7/5ZSRwT0e4qDA+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972710; c=relaxed/simple;
	bh=tlde9EiUe5H7mp3ddmd9ORPYCD/f9shKxauX7FNKI9M=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=nBM2KiKjiKkN5nlWPjO/mtsoDM9RvRRdcrstpTMrDvS76MoVIw3O3gcb6VxNHWh919hmbSzt3K9MrRai80K8BuB4sKhsyPyMz8y4y/XbltKHyYKWyD/TCRp3dT/A47qcijdQADebCRgCU2s+euVtD1/t4MsO5YcMUmEPxTgJ6AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r91JeBFa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ibSuhE/b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFkZ5t975855;
	Fri, 20 Mar 2026 02:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cfZULZU1o9PFVTLrPk
	Vat199EGoUtc7cdvZ9JnWt9m4=; b=r91JeBFatxBEumDgKXJeydEJP7/LMur6mT
	a2m3gvZgbrpu1kZhTG6dYGfvkf2EeQE/GCAsFfmYRdW+7B8saAz0QBIAwj2AZJJV
	3V9MxF9jfFHYVkZzjPx4zS9Fvgmapo63naMgd0wYAdzafkVLyuXHZFc0aeDhJST1
	GF5OffMaQ3g5L1V2H14zvgG2vnfxKsCkbLj+tcRaFQfu5DvDnKNvIcdve9astBHG
	5Kd9+xj2nW4eKRfcLZr0z353Mu2mycA5RTJliUXVWIgYmRzgtrAcX/fLX0wQ93Ow
	HzgBr99r+3iDh78LRP19UfBicB+Qjb8p3hspsgQzDGb2Nv/yC61w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rgym0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 02:11:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JMO4Wt003427;
	Fri, 20 Mar 2026 02:11:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4dnr2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 02:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S15PfkeybankWU96IdEUNgyiGy/esDIRJ9Jpa0w2jCJ5Ev/eLvpETeQZedxC/1cFqZsHONoQ/3aIvkNPw0YA5FuBgjFl55CBFtJee8taPs1ENaKz/vrn3GihjDus742i2QTS69/VD2axYHhje1y0K648nz9l+Km6tvPs1GaYPRcRp44PX1vqfSw7V5VfSVH5MnnvFqoGp5P3QHqLMpduB+PKdL5/vFlzQmuC7/UHsfh4uIAxVlvuGDLlrR/W4OAVJ6Nta4h6aG/XT5z/LukzJn2i/1g1IWmZM/UjqeC/EJAy+oKIqg5W5YZR/NuWLuIVSiBw6Z854cK5vNpzS2sAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfZULZU1o9PFVTLrPkVat199EGoUtc7cdvZ9JnWt9m4=;
 b=B46fkJtp3QHlQ5j+C33hFqDskAkC3+/ezTpeMLD17zt1Z8ewYYu28sXKUB7F6vSkU8tpsbdtS3ycoJcHqI/THmo5oEGSP4gEnGMH+86twYMQc4eRp9ebU2lEpWrNzx6HHXezIRie6ruwcNG4tQL0LQcKm6/KdgCVT6WMqat/e588SeujTG4GZ0Xli9JcdNIPMgUN0rljpqupKiKLtNi9q9bez6u8NmIkRceC8eKxm/5UZjN/ev6Nf2IafB/AbKh2bIKpZRBE6jrBcE1Da8WK9sAO4h1f4ZpY5tv2uqj0RkWbUOc4Kh/KYMoOlbupoayZq8U6JbA/68YXmhnO0rF1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZULZU1o9PFVTLrPkVat199EGoUtc7cdvZ9JnWt9m4=;
 b=ibSuhE/b6MToemu7oHxvUSnzRl9+9RTo1oE/A5YS0CldEnIf0eEtOSt4mucwFsxkIoEvatIL1aFd/a5xjQEpAZZzOpMJHZYFAeOOIQ3PcsP13KqpXBV9wPrLdhlAgOPFVetRlgkd8abS17UiCWDOTqc+Lc5V6BgiBbpVUbp3q1g=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA4PR10MB8587.namprd10.prod.outlook.com (2603:10b6:208:55c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 02:11:18 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 02:11:18 +0000
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: <linux-phy@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <spacemit@lists.linux.dev>, <UNGLinuxDriver@microchip.com>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski
 <krzk@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v4 phy-next 09/24] ufs: exynos: stop poking into struct
 phy guts
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260317230500.2056077-10-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Wed, 18 Mar 2026 01:04:45 +0200")
Organization: Oracle Corporation
Message-ID: <yq1fr5vl090.fsf@ca-mkp.ca.oracle.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
	<20260317230500.2056077-10-vladimir.oltean@nxp.com>
Date: Thu, 19 Mar 2026 22:11:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA4PR10MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: c1734605-c481-4755-a09d-08de8625f8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xMwfgJlCcIEbR2jPQOQMAidSQ9LdYrTnlSZF7ql7HVlbwksNwQYonA/WTWhITFSCdMwa73wTCJtHIjZpk0fQdTScUVmd0OB/6cPLPcJSe/TyqHK7ATRhaBPnxqtKG53B3JFc16x6n6qQvTDb8+YrMbz9rvtmuLrm1BEYmLGcXq9o4sMVIoAQ4eJXVupvtoNeraCfo+49OvC3hFQAzGaDZCPpQpszSwiLBaBeE3W+D5pDw8KwXCx8Tsybr+o6QblaIuPdLGMMc27+0/4LklC6xARFJOPhE8cKjRy+zJQRaMHCNrk1fvt1qNgQxttxuQXxqys2DcNtio5xG+C142Z4BkHdTrh2OeVJMkSQn7cYdT0Q6DQz/Zmn9K76a/7CqVVtm+/9z6L6GPhI0xF9syoX7HVstGYQFV1V9GYg5IG1MyulAlD8SuYq2tFH6ytopjlxkPbLaQo/F6MKNeVX+nod7iQgQXQT4Sv65fQnGr6m3/a1kgmp9+zKNcrIY1jlIfAqjsnCQ1XN3Z11x2m9kjycITSNNhG0sPXSUzcyqmSdmbfPJc4U27g6UEaIMElrj0aQZTe/BsAEQcM16eBijJn9y1dZhDQNIVQOAP4PSoPP5Kzm9EpR2LB6ZtStLwRM4k/HP0GUB6OhF0eMtYu/0HPlBxmFiiI9hI1R0zi1A5/ZIW7SyvOz12cpkEzxj3c5sjlnTDa7op0kfLjNtJTI4Wfve4GHTvP5zeAT4IIH9fgt0CY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wImPQe/cVJdVXrXLgy77MeKaWngDbfiuRgyPaL0izCmeTQKp3QA2cJWTn24q?=
 =?us-ascii?Q?p8XCCLX8LssU1yJ7bgwHsHbaZtqdpz2HBRl6iDXcTXVfxlfv12qw42++WHQM?=
 =?us-ascii?Q?YwRYWPM6JpMQvBcqzihb0xNrVak44GS3SaZX7xgEVlmZACIgVd1OgOxh0QTX?=
 =?us-ascii?Q?kDFHX4EqqCtT8qWqJifpUEkjLL2bBomoqVyU3N0TkVNTw/lbwvEuq4nEBmz3?=
 =?us-ascii?Q?edguLqSM3B2vndUqZ0P22rupDQftBRPJG+82QI1xTYZntCSDJKTXLRypkzbc?=
 =?us-ascii?Q?N3m4KLpun9d/BAYahfbrDKTAd7p8BTQFatbnBp2p+SZ2W5l+y3IFwjn3RYkm?=
 =?us-ascii?Q?PPdNnWI1HC5gasiqmi/3Yy+HKnWp40AalNDSktoa7PxMFWD3Hawi9Wd6WqQg?=
 =?us-ascii?Q?b+GvwWvt4HjCN7SkBpPZ/w5xeHx0X29cHmEDeyg9fZEJibXpm+bXydnr2Jqr?=
 =?us-ascii?Q?RU1bdKxmn8JmPGvqo9FNqAUBkXq2INfAgj4rI8wZN/q/dZ+A0DZEMgOLt7cY?=
 =?us-ascii?Q?W+9tRMXifGUR4CORd6YPb7VnzkeAcaOQHDKPKeye1zWK6UYMi6NYUzQe2MKI?=
 =?us-ascii?Q?wo3mcNEH9koJjGx/r0TWZqH5EDo7MlHHFT+RAf46riP5XI+0/RlRMMGmOFoh?=
 =?us-ascii?Q?n+xS0XwUVUBMSIAJ0Bts3u3IXtwGep+HXRkTINipgnhT89DTm5zxeAJkx5Ek?=
 =?us-ascii?Q?5pTZkV70HXQHfm+MfQ4bilE6wRLgFXtvLgE85ebC9honrPMUwVDFq64U8Ilw?=
 =?us-ascii?Q?u58Ng5SsMIzWtX4rq4eBTo2+XH6MgM60oxSqdHcHWa30mZn2ZRKVltIbRiJ/?=
 =?us-ascii?Q?NcsU50FS6QsWXMucKgMdgOrvE1GL+M7V91YLl7fbXNM6iHG7vz9/UA0pBw7s?=
 =?us-ascii?Q?/+qqDNX0ZNQDvdKvwSP2MTi5wqdaAldmvneRsRaQqrHQalyaR64YRGKACqV9?=
 =?us-ascii?Q?8vaoFrBIri9w370xgwBcCQV8UFDRj7jVNS1B5DgZCA/j7EINkr1idHevR/cM?=
 =?us-ascii?Q?LDrUJOZLnMc0XHWZ/dcnwg6RGIkaWYZ600DxzNqG8ecv1vpwfuRtaqAS1eLv?=
 =?us-ascii?Q?18cUbfdlzcs9qF00jcoCkvIPOdCDaWOhsu7snuqzJXdr45mSWqqsmxi4lrcn?=
 =?us-ascii?Q?W8NMdYqqpk3eB1lrRg8k5bdsyJtsQT3n8RJJwDVxxX20piVcd66y1i5Rkt4l?=
 =?us-ascii?Q?/xuvYHU4UMkx4sPMcu7XQKPPi1YXluoEWyMtVHokHpZDDyJ3SSf7hAvijOUd?=
 =?us-ascii?Q?Fsfk6pnVeE6eXS3nLPD89gTL9Qf+p5GeXO/IsRJwypH5PXx+Bng/+LlNGv0j?=
 =?us-ascii?Q?TmWzc9pVXXJV9IbTvcr6nUr4pMJgSt5CRUYGjFKi6l6366dfsgpPkyqlX39C?=
 =?us-ascii?Q?Z5bJkqoVVOoPrJHF3m/3GxTh14R33iUiI87oyy0/bv0X1T2mSVHNVedn4iV7?=
 =?us-ascii?Q?jav+CCOABWGNZEHniSkMxp3Hhx9kHwQkxtg3psID8dwnKVZEBUkFKRUuTEBQ?=
 =?us-ascii?Q?XshJWJkyB5oTsmKfLGxUkYsFmuQ+ClVMpJyRTCADo+MBVhJk4TNxFCLAVK3a?=
 =?us-ascii?Q?0UkvQge89NNwE245miV9DATvNjpNq7iQIablcy+0vsgjNGUawCV7dgRQYfIV?=
 =?us-ascii?Q?VK3Yb/k7DSoEOKOEkha/VB3P/AuDWNwtbJnH7AOcXFQGdjSyggMRKI6iHOjh?=
 =?us-ascii?Q?g7hkZL/LA54nsz/QCmjnZwOKN+HigMJAL/iFTfuT9yPt+73WMdap8DFBlzEn?=
 =?us-ascii?Q?++n38EiSQO/WsdiaHrZTbBsxcNqHkXg=3D?=
X-Exchange-RoutingPolicyChecked:
	H8jSffUDdFv7n2yLNHcylzLTTHp0DYK3tElbip+DnyGkaHgdk1ZKuwChvgXxVk/IvLkX5lQnYsUdLIXB4sqGgkrGIr/XhGT+dfRh1UKLrgDDeyGgisA9/NORCs3HvmePei4FdiP+99NOp+khitn++tqmarj+Ln7CtTHwhgVDFU5mVok7H22SsVX6zBtbmREe036ZoIX8wut6k0wmqIYVl+dhyBoHmk2c/NzKVkL8w1oSY7S+pk7kUJ7iFj2Mquy+oNtwW3yMIPyWOv6LQLx23PuWQdxdJNug6CDJuOKKsOVVJ9/jMzNUWsCx7q4YPB9r9fAm+v3A2Jxb69eSmeujPA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v/L5Z1vlYvbsGQ7Jle3cH5CPiiBoSy03zr+i86+1aSwzkyQ0v1HwpLcc51vFmctej5saowQ533hpmq9sEsAE1tdxHXO755lfpCQ6D7DCQnPrpCFv+M9Pbt6CPN01zwBhhXi6SLapC4gq3kZ2RYkZlqMMB2e3W6V+q+OstQDk/qUpkRZ4hom5ZnW7woID8exFDM6SeRUU5896wl25QdF84HRi/PHfJsducCebLwogu+3yF8QmO9luIMvTPFDuC+FLWEeuDxgkkiNz2OrrImMinlSPF1TV2itx5jUjRwxHXhn8yR0xKes0rOnVZwmRLzN2PgZWEed4j81Bx3+FdEpQ+LXmLkAn+ZGN8VSpkKQKym4xHodKjlAOVy8iEIetm+6ghZm8MZ8hqZvJqjaYqBV0WqCWUTbrnoUWT03gmr+hHS/u9Jl8KjQdunC3os3b8iioKb4CSGUd7oLpQirjIx45nc5nsnNQgshWRbNBsPQVLXmaxthUrtijmjZxOTc0f4i4H6/VM16w1naKCpwLPHSZuk+9Dsy9wAqrXZcIFhDbi1WS5uezk6MIIjWHWo4fgYUx3wY5gQKOl7PXr6miSuMsrLIcuYspK9ssbZND0nm04uU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1734605-c481-4755-a09d-08de8625f8c1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:11:18.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyVfiNFG/T9yVSB9J0sMQoz8VeVKA2jmv/+tS0Z+0cau0gwE2NY32CAqTRc+W9OUNiAPySTptksh+n+7C1Msu4douSIGsjtZYlcwszxt9N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=822
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603200015
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bcaccd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=V9LyDDkgFULS-D7OFlMA:9
X-Proofpoint-ORIG-GUID: rkXLPizU8Xhuq5wZntyuBHZEhnq6NBPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxNSBTYWx0ZWRfX9VqJ0sH0R86g
 zzUtRMM3Beq0lXc4HDGDRYvYVErO62pqWKdDBq3lOs1EV3JYMv9PRCepbuhonp8QdPSXbGV9etu
 pqGvG6uv3H4PrhrZcMvCaGGM7Ay5DPnx+XmfcBTQC/xDankt4CDH92uSkkpOJQFWtkVL4KVcmNm
 y0iURWgrGo5BN65ARQLnozqj4M5OKSn5+UuLP9ECPy7SmTcojEgrHf0vzSKfe8ixD1yVrfFRAKV
 kZRF6P8kKZonF2oYBEMVHWSLN3+jNKH69vFEv/bFRlEwomp5Nt2MvftYysK4VJhqlzRQB9llGp8
 NM15itIIaDKkbBvSSR6cLsjwxL1HSC3dlAd07lbTslg9FzrmWfOE3uDGy/GnUeQqS7SKnFnHbpU
 O3ZWlF7s0jGy6iwUFapvVfqUg+Yt6HxEClFpDCrdOaTmrdNSEHhswOmYAaaDVVjEycpor0kxxOl
 5QO7LQ7wLL6EKBcLGZA==
X-Proofpoint-GUID: rkXLPizU8Xhuq5wZntyuBHZEhnq6NBPM
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7196-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,ca-mkp.ca.oracle.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A49322D507D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Vladimir,

> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.

Looks OK to me but it would be good to get an ack from Samsung.

Applied to 7.1/scsi-staging, thanks!

-- 
Martin K. Petersen

