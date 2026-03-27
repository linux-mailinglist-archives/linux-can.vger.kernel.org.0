Return-Path: <linux-can+bounces-7295-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMx4OanrxmloQAUAu9opvQ
	(envelope-from <linux-can+bounces-7295-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 21:42:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66134B2D2
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B3BB308BEEB
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894C391505;
	Fri, 27 Mar 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fsy/STBc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l4HwjKbk"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2C146D5A;
	Fri, 27 Mar 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642860; cv=fail; b=W+EHRG041LxvE98EdXJLgjwoHbWCnzbysdyxqncKkQM5R/E/zDc+nWfryeBgtNWdzmfPlUGvJPjHFHLPWLApqHgKlfTkKW5wjqcKpCMnf+Uu1+VAwC2VsSiE+zCTh50Wrsk2OEjg07mkvNfd+BqQeiriPyuVoR/9qnquQA2ukQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642860; c=relaxed/simple;
	bh=p9xxlEoIiGz2BcFPlG7RZkJyn0r1ENB6aEr9eBYWhZ4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=WfQp5yE0/pDzdqV7XttsipLuAcvCvB3I7BeUcct92SjfufDa+o8VwxIjx4M+g8TkpDK1JnBcjXSHTyEhbbx8kZaSf7Ky5CArrKOiPOr2FPHZa0ZTlK2zx3MV0OH1B1jsfJU+kS4KiJw6kDk9XwwuNTQIXioMJQqRGnnTzlyG1Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fsy/STBc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l4HwjKbk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RGu1HP3771475;
	Fri, 27 Mar 2026 20:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/4sQG77Rnsi0MhLJ3m
	He18f9KD/0gnBqDImIeyx2M4c=; b=Fsy/STBc9NGEYvns1SYwtuWHfWCeHg+2rP
	2z92lNwz2JZXVPpToWdPP29wpTrTY75iL6R9qRRHa6W0wQAiK+ggmGVhyrukWqMy
	QWH+XsAT3e05TFcU7LqW/poOEzxfKZ6m+PuaKLrmRuP4XEkeczdYQjhHenx0CRXb
	tNDIRdY75K0rGxVvL0SrqiaZISDskVca2rPXDZ8iYS065uA/ef5OE/Br3BdhdjLC
	z/PWegJ0a05eL/u12tfFmBla3j5Pges38Z7oK7yAozpPKJjzewuUW30LSXzS8qlL
	rzrJoXWzkk4Mg0g8hcT8iW3BoScKbJCtqR2UVqDQxh6E963mtTcA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2jtev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 20:20:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62RJfjhd038380;
	Fri, 27 Mar 2026 20:20:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xuj2t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 20:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a83Q7Wz1klg2pCkKfPwfGQTTTls4anmaceIhS9NmiRc+vhSigkKpsrl2nkEn022QPqOtSXx9ZqU+lckpoz0sF9qJUlOINlA568d25XJK8prl4yR7St8yejGLvabqWEdEIK6BHtoXMqf3l/rpRofF4+7VRxLBPvAMqeBRPwwKmFSDV5iW3ScfJGMEdXRsj4V3YcO2veajV26CmNctS/8vmJwtMszGCeJlHJIxZcOLz/ms2AJ35L1XF5lJ+SOACY6FBCGazapicOdp/krbxGvb06PaP5dqDHSrrOMeQUaHOHaEn4UTyJ25avyqvwiAb1e3bPQaBe4NtU7PZwTrEryILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4sQG77Rnsi0MhLJ3mHe18f9KD/0gnBqDImIeyx2M4c=;
 b=h1YdZ04LfhOuUhr07qIhW1ngfh8+pvy5dSQubW/vY21OHD5HnWDLUjdi9U3YyCkYiNdG5HHi+j+64Rkb385ijNSOBZsxoZvOZnSqIJZOendMANFO13DupiZlYNO7RbzuDwmjKhZWwiqAHlfKOSCKCHhuyl8wwFZMtcrtPQoylQp9d8KLU4KvrL3WNe9FcGTlGZ163rw100ZfhOoLyw2Lh6L3RZmBtUQsqud9O2g+2XhDmYwYjOTk5dOuwjkA82L7rKU47twtpDZBfk399smTerK9gkAsc6Snjza9zt6JAHzIWrg5wWAi7rp5bJEEYY5cFeVJsEYuKRGbbLIR9eo5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4sQG77Rnsi0MhLJ3mHe18f9KD/0gnBqDImIeyx2M4c=;
 b=l4HwjKbkkROesAfvEEhApWjopaI0BuVih9lh8nbRHm0pwWsy/ulGi8U6UG3GMylEQG/9Hrk6vX8K/AIeaX/x3OER8IPhmW4B92hLqimPeYJXPG3ilLRyRW2DcUAcT7vsSaMGIOfUjCAWmHpVu/9bwnHOeD9No5OcyAdjh/fJs5A=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 20:20:31 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 20:20:31 +0000
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
        Manivannan
 Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH v6 phy-next 11/28] scsi: ufs: qcom: include missing
 <linux/interrupt.h>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260327184706.1600329-12-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Fri, 27 Mar 2026 20:46:49 +0200")
Organization: Oracle Corporation
Message-ID: <yq1tsu19g8y.fsf@ca-mkp.ca.oracle.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
	<20260327184706.1600329-12-vladimir.oltean@nxp.com>
Date: Fri, 27 Mar 2026 16:20:30 -0400
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:610:11a::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d38edeb-712f-46ff-dd51-08de8c3e4b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DSNx3qMfIWbpK7IQO+vumNk7C3N/AgFNjMpadqCJNRbmiHhZXbBNristikLW4084E2gCS4Us2oAFXVQjxi0UHVrgefngGaeCWaJqGcxQ7bFvV0GjQBFhsfAgIa2Es0P+3UEkGDKamVfi4noUluUYjKJvYIjPY0htjs/XhZHTmOon6C0K7wXvPh6p0cnCz72er2EjnrQWh1kHALkBjo9m5TEeIw6RGo8ZOLUsIIMaMtIDn6cK5ygSSE0HPW9rvHHTLlI8G/g4ZERGl/wrJqFr3rqAjwtKzOCLTPPyRL+fEtboYOLN0PD3ftm1Kk8+L1Qx/o1SZrxSOE+zlq/p9wECOCSsjpeLLNYWM4WLlqi63l0mhQLLULNkj48UONAqSGGi0Kw2dtdQNBKuIiJ4j0YAxWeou9iRKTUSe2urcCgJTv4uDxSKQTMKY/TcNadzzqZPcwDqFv09MveEIMJmSC+BqfePPvNaPFgX0Rcc6pXhDurAaCLECOVXYNUn5WYXAHZTyghcVQp1RPXH33cavrGkY1+gn4/zXIDB+t03NFLt1hzS6g+kCJdmLCTAezxW+1EQ8aPqDFSq9k3UsXdEIl53ee+kCddchR5ZL5kfTWeIVpDUq3uGNTcMkTh68WTTdn+6fgOBqjTQTR5BKtrau88ij9aadTrjl5NL0ID1oFyJh+OarJUp7QCbuFm7gVSxVkOeJK2aqHkSLQFCmLsh6c6be6oWFVtf8vjPM+2iPMq+Yaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KBrtVZ1RvV9x9v57pzY8bS/rTd18BDctayHCFYg3Qp7Hn1zjonu7/Jvccm5?=
 =?us-ascii?Q?6uXIYpho31ELaKc7YHsOntEOHnZ3onh8Kz06zBoY0CXnAlYhVTsGby0wKXxQ?=
 =?us-ascii?Q?XjkXx2nz4shCCZLtpe9tNM7SKOA+5zwlDDTKOFc8b/vQzMoUcAfysuN8b+Ws?=
 =?us-ascii?Q?oH20n77yMSHU8UmyPEZiqWCTwPcOd59qpZfDlxpVMyRYNnImBdbgssLcTg0z?=
 =?us-ascii?Q?RvTzOTgoC3Qs6HFA1R8sU4n9HyJDyQr6SMPC26Uook3C0tX36bJE7JnKyVCW?=
 =?us-ascii?Q?0lj6VtTITcM8eTPaOtS9KfTG8xCer2o8KNBYaTh8NXE3Rxfh0ys+oUz7CYVc?=
 =?us-ascii?Q?80E4tALGjvDUmp4g2ZDvtaFr8fptakCBn7hVwtCF2gN7hzyK08z9KDpmn9C1?=
 =?us-ascii?Q?7NdRSCG0ELvdp171w4pt7VpCmJG36bvaRaOkqGD1MlQSclVG1FalfJt/3Zi+?=
 =?us-ascii?Q?OJnxq5kesmjVY07ikZtIPlzChsONcjAPFM92RdNMm7DmSmHN4AyMs/XP5Amw?=
 =?us-ascii?Q?xxI0MF1VVnxqf0ZzWF8vh/nE+ptakI2da+F84bUTWkO9aSSMXTdSiJmXcone?=
 =?us-ascii?Q?Sm12oOY8J3n3Ihl9BDxDOLmQa8Sg+lCpuovylJKZ30wIJ4OJY+lhLEEz/Kqo?=
 =?us-ascii?Q?fy+oajVlxWpm4TDPUMj6rGdbA9QiyoFZnrnMbgw3TQ24KgRYfYrFlsRwpJIU?=
 =?us-ascii?Q?uKcx9UvWfSQJVWkg+fMmCTuTOzg4t9kDICSO0Ceh4YA+za9LpdsfprXMTgds?=
 =?us-ascii?Q?wSf3P8c84jAsXZbuV0RrWuzBtP3nUvPGOITBDyv3Erz/BiXu6XXBnmv9DqWM?=
 =?us-ascii?Q?zW3nS4RXfOCpX4xQ7CsbT4cyL9gNnjMAk5IzkARS2ALxTKVYQPCG5ZQavGGy?=
 =?us-ascii?Q?4RxWY3ArBT8NZ4HBeGMXKlNLjMgUOE4Gi+B3x5Gp+wB8pkqcVMA/Y7sBf3I6?=
 =?us-ascii?Q?muE15+dEBsjxyC2rZVH4/8tvaKuvMY2Xdwu2RT8b+wbl10eQC2+ZtS1pN10c?=
 =?us-ascii?Q?d/Gn/BWWRgUZVu5LcrHdiUR+Bwe3Fc7XI0utYGbk5O7y8WNFaDUcxYfvqn+X?=
 =?us-ascii?Q?XzNP97WlTsIUB9+/XB6PZMd1RGJsKXROl/Ku+ZI9Jn79WihVBoibBLxHs9Ef?=
 =?us-ascii?Q?gyyG+zAbZJXRHZqAJgZK4fk6ILiM/9xFZzia983phuNy/Se7cjAAKA4bkt6S?=
 =?us-ascii?Q?oReq7msfXHnFjexl5PnZ6Oa/Iapy1w3KGBCQziGHqozdLqDgHf4nFHu0lejR?=
 =?us-ascii?Q?vQzxbUidBBg2eGJ+m7zLKHTMtajcZgHATSdTkJaaT9MpMh2bRUtWlnSX4Cex?=
 =?us-ascii?Q?HXi/GMNmDf+UJbQPLl+S7hbZJ/vA0rpETQOZ3YsjzeS12Kh2vz9LtDmSkhkk?=
 =?us-ascii?Q?gJZmtThRSvgEBWjYoSYJ24bJVLNBvvb2gsJbaxLAgbdFJ6y+wwL5k8dz6Ja7?=
 =?us-ascii?Q?TYzq53anOqEifAB1/fW7MaXnc7mUJ4xiuHSvwQHOyKdqy9UxDYoZfgnGegAL?=
 =?us-ascii?Q?MeUfHlpRea8Xzg640bkWCCHfZGEwcOD0Au6GZ2boZKJmQofJRQhSGbNS8Qgr?=
 =?us-ascii?Q?Hb7H5D1smVLoFzhciGc9lyDk4WjChi/nm3T/GrPc4/VfW4AnA3WdbX6tWi9S?=
 =?us-ascii?Q?hvVQAaKBYvBY9dIv6g/Jw3giiPZSg89rjp5JRMt0hUb5UInk/GpFCrcDfHUt?=
 =?us-ascii?Q?qoPqEEYjHVlQwZtn/CoUHiQZzZBclvResiHP9NCt1xEx0g8Ss/nEyQzdWNCC?=
 =?us-ascii?Q?Guv+h4dvvo5W5CWNNePLDIdoGL18DiY=3D?=
X-Exchange-RoutingPolicyChecked:
	csr2t4K+vjuLhqKTuy7GEX5yzoUpAGMUVmrr0HlHyOQInIf2+EMUauLOaYDAlY++UqJVgd+iuWFtXahbzEizLW8zMfAR2dciJkCXS3tnuf/EIsVx1rqiuoD2dWewxWBmUXXSYD4JH37+sucZVgc9fU+zCMqj8bKVXn/QJqzOg748i2chspEMImqI54eRCoEGB6GXg9g3efGJ98A6KeXgQiLf2WuqxQjaVjPC6XdK2Jwf7vgXNJoqyqpaM/g28kytXH1q+eLTWObWileHwUnQ1Q4XR+e4C1Vg5OtUrDXFfMb8+K4WiZRyu9h9wM87ZYDxErzv5pJfSXtmOKYtPRQFtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XykP6A1xO2FJ/87DTLPnl+yCWgzsOF0EuSrooZLbwTiwlirfgBhwl04EqazBjr3cLYfRdxb/CubZfUWBR2bgFPUirOl956mKTYUm6TSFu30CIP3YauKzkexdpzTW0L/33zAk/lh4Tp8Hjc51qt9EvJJxm8oj1TKbulxw3Ot4kJXPSAwQKXQtWPcf1w9qCu+yMImGUnU6237heV2AKXIdBpSN/HfCCEdaDmK26p2ZhY5+LmcdzOXog4W+qu5RyX5qWz1NrnHx/rr2msP8mNH1Gmr/Tpi4rf+7fQfFK0F1D79enCHl1PPJwKJQbS/vgQ+iU1pfY1sRv4SHCxIX3Nn1erkZFbPkQQsaiq0yHcy2iHihhNih2xpdaI7XYhzCV6+jaVzwsaYrGOAKUYXqMtxwGqN/LMqZB/rrZwY906VgxTFG8PlGALWuFlJvTEke1x8ICumqV9facqKEoPPcV+pVGORereHS6smYfW/u/EKyRa4R6ZZHrL3dRhkDiUbDxV/QKFuNlM3Xa5/fD7SC67biFE3J2M8gTyHoB8vnd23dS3D2mLLHqM4hikNkG+JFjdRwdn3hAsgFegHei2KTD2ITe1S3uvw7O0t0JOlloBRT/AM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d38edeb-712f-46ff-dd51-08de8c3e4b53
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:20:31.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+4q8fS71z6dMKW2eLzf11lN3KLIvzhPk2GZJ+q8aJ74aeHGJsL+W7UX8cFyWpV5b+zsVbHLmWg/0Xb6f2VgDOVjbD3g8TTdplOzR/6/ncQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270142
X-Proofpoint-ORIG-GUID: SqhaSZ2GlbhU9WE6peMkWcPC0MDIYuiQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0MiBTYWx0ZWRfX5QeZ4bBq4evj
 kw5OZMrKKyZ2ltt/BN+cCRPNLvxTOQin0cGynQKN+gdh9k/h+cpHw8bcHJTlXoPKena6Jjwrg1i
 uGbNd3NRBZajlCMz1DsKfkKDCgl3J7njy+AouvHSoh+Kp9ojOORUv8q11Oks2ozEzTP/W0WgWeg
 V6XuBVnzX1IOSD2JdhxMEtPNSR9bxIrXIcL6B5KVYoc3Cn6G0GzNvpIsSdZ92N1yEuG/GTXffEi
 usIVKenOnZaqJ92+GB+nDrvXyl2CtKMHyrhqMjtjfrDEhhEJZXIKGSOKOugihXjAz8zlCFuGME4
 r38WMQHEcTtMIQEB/cujU85yroHQohk0+pSwv+iENjI5wXZZZFq24h7IBClfAwdWQKtVV0ylZ0n
 tLrT8iVUN3FOsTktAmm7W6QkJbgd36CNrtq/i4qevdJkYlUxF7YLshYfQceYs9JT9j5YvX6mMVz
 zRrrkHQo23xudZVXCXMMUBjV7a9CEa0XMRrVyJgs=
X-Proofpoint-GUID: SqhaSZ2GlbhU9WE6peMkWcPC0MDIYuiQ
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c6e694 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=pKwsvEHCoKUmO1iIalcA:9
 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12276
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7295-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3D66134B2D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Vladimir,

> The point is that <linux/phy/phy.h> will stop providing
> <linux/regulator/consumer.h>, and this would break the transitive
> include chain on armv7.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

