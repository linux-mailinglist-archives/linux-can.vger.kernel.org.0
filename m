Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146014679DD
	for <lists+linux-can@lfdr.de>; Fri,  3 Dec 2021 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbhLCPC5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Dec 2021 10:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381603AbhLCPC4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Dec 2021 10:02:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD5C061353
        for <linux-can@vger.kernel.org>; Fri,  3 Dec 2021 06:59:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mtA26-0001z9-UU
        for linux-can@vger.kernel.org; Fri, 03 Dec 2021 15:59:31 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-4c70-bd43-38a4-642e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:4c70:bd43:38a4:642e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 567E16BBB98
        for <linux-can@vger.kernel.org>; Fri,  3 Dec 2021 14:59:30 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id sIHpBWQlqmGOJQAAs6a69A
        (envelope-from <dan.carpenter@oracle.com>)
        for <mkl-all@blackshift.org>; Fri, 03 Dec 2021 14:10:44 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E9D7A6BBB1A
        for <mkl-all@blackshift.org>; Fri,  3 Dec 2021 14:10:43 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BB0C76BBB19
        for <ptx@kleine-budde.de>; Fri,  3 Dec 2021 14:10:43 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dan.carpenter@oracle.com>)
        id 1mt9Gq-0004PB-Bm
        for mkl@pengutronix.de; Fri, 03 Dec 2021 15:10:42 +0100
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3DZF9r018040;
        Fri, 3 Dec 2021 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=eGmcXvWRF3hCkXgvW9gEmaICcduPX6vpYpuUY7hmI7Q=;
 b=xNhpyoNg6G3196l1ueyxAUD73m7SlAvgv892YVFZcNSX7otOkK8VjN3XWSPcWaa80oHg
 VeSjFMq9q+1+N/eNAenNYJIAZFPAfwykiK7+oufke5zb2zYLi2iaMjim9Csxq62tqblt
 N2OnNY5EwzIUtganSwBXr9dhUsnFwyigFM0kgAXatoMq59Un6U/K2amcR7ndkYKZn7NG
 +ojiq1SfRZ6xVf7wUU+bNIb4fizS5kjxNA2ZGeoaUrRvwjHqTww8JlDmseUH6GnPGfQy
 Jk+nhe7THO1NVjhM0d007jnKcQbBVkt87CSnhgN3ANC6x/UGEGjUTLZb6No1IOM2jybp Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqgwmh63e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 14:10:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3DpmwS172884;
        Fri, 3 Dec 2021 14:10:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by aserp3030.oracle.com with ESMTP id 3ckaqma250-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 14:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbwhy3urWSrAwtNIwqgfjDRzcsydDyVRA0MCVG6UA5M5meFFtFfzTEMWNf0oorOmK4zxBdDsFAlepnSHdS4vQiZGn5hc8T77ymq0zTDNnnaF+JXzY4txB0j6BlYZHof1hvQyOMYZussrbYO81lNYVYGs1vA0Iwp3qtlGXmrXvQDvEvmJvtqTFw+LVGeu5I2eSwIzRGslMvF3QHYEGofxeVFp5ceT47cMeRzuUrDzypS1ipP++YZEW05vj/RiQ24dJo3IX3+PBFXLDBC1XQcLR5ggPGzonRPl3cCL3sp2+BVU5+voZ2osutN1lafJ96cTXR491L7XBqPZlxvQ7a+ueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGmcXvWRF3hCkXgvW9gEmaICcduPX6vpYpuUY7hmI7Q=;
 b=WgVwTBps5RbxMgoJFARc8N6pvjPS3/HiAuG4si8t/tyO2PbzqBtwpsQoHJsSwVMokW4XnWAyWP39AfWmEKBu6MIJDNK9zeUNIeBVttsxRquAxuWQAhY4a6TR8SUTTPn17vPPmOaRtfthW296a0CHfSjq3Mb2vf7bpCpyclVsPeCbx2AWwyRT4QR4CbUiJv22B75xieOv4Nn5BKOs2phMUU6o2I5ViDmaC/Ce3MSikk5lnLFz9X3/XJup6EpWU3FFl1Ijvj1blSkXJERm/z64MgpPmhEWvFAC1Y8xNDKTnG8GlEBDwcg1iDlPxJEXN24r8YSeAPQ9s5I6k15ZrVHYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGmcXvWRF3hCkXgvW9gEmaICcduPX6vpYpuUY7hmI7Q=;
 b=jOPbNBtGF2LyS+a0bfhUoa0t6aLkaM+IKfN8mww7mrXFoA//VbBifahvK4I0Pm0d7W9x2bjmIKQybDWpD162VQ2CuWKnmL+ssw1WhABI16+AOmexmRjmzxYS7qNHKc3tdKC1NbrG41P0Ril4JX6MUsKBQSGzPNOdYy8OnDvEzYQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:18d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 3 Dec
 2021 14:10:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 14:10:28 +0000
Date:   Fri, 3 Dec 2021 17:09:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <202112021833.wABxM5UN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 14:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f573aae4-8a8e-480e-fc87-08d9b666a84c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5749BF5ECC96DEEE654ACA868E6A9@MW4PR10MB5749.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kci80QG1kaDKWo+YXy+/ICeX+fQgxPG89hfE5hV9e0vWkvKpasOOPURV8IWwwDf8Ygsghm8JYBgCP+/nqqMnoehbMxiTrNDu3QbbAOK2AXzedFWDHO9pv5oCAMuZ+sW2s/6BbQFE0LROg6mhglUuAEWmlKs0uIgbAXEU2EH5N0Ix9FdD7ws5zJjl3agGci7xoAbj3QoFVkaLlZvA5lRDzUdL2r27dXqtIafMsSwTcra+H1gT4lyUmJp2oGPTrF1cInVMmIyJYVVi6wrEbYI9MYmYogV6O9WLiskjw+ge3OkkHbyGFRWwULZIVFFBYA48PWLcbseq2u5/8eJpZjTqT2rU2hS5Fox5LeiyQMvz2BL2rCu6EhV3PNdKz4MIEWj6LJb+GuKjZjBw4EG/MnsaBmTGb7bZ52Img31x+22RHPHqiiPVOfd+8JNmZ2hPGhaPOBZxzi/dEp2ZlYdw0r0M1uSpRY1XZ+jKnZPm51k8AAIgak64Aleux+gPZceFDfq0POrgdop50lTWcwFN3FJ2fNs/+5+rqMHzf5gXti+TsZUp1SYR+A3+metklaBFwVqCnfPwtE0KdfA/WFsPEPzu9pCHkQHW4HSoGL0PP2R4/R/r+A6lETRKvNObRCNwOUSZiro4WD7jG2IjiP8Xr7MUwZfwHWt5nZT4i0m0jZVN63Er6c0TYdGfTIwqLmqe6OJpyV0XZbHMXAYd9mhXowgaGxM7MNQQF5MTK9d6Lpqhfu0nGidZsrt641cdqw2Bi1VN2X5hFKowMtsUyIHkGAJNc+Aocv1y0RSApD+LU74KsbGEurC080gM0aBCJzPh3eP+RD8TIgTwzZaB8hkxZQJEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(83380400001)(86362001)(186003)(52116002)(1076003)(966005)(36756003)(956004)(44832011)(8936002)(8676002)(66556008)(6666004)(9686003)(6496006)(38350700002)(316002)(38100700002)(6916009)(5660300002)(4326008)(508600001)(4001150100001)(2906002)(66476007)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zSOSCRgzDH/GMltJQfhsB8uw8ZYYSx8wjOpiAIbDVrYc/d8qIVoylRjOSxAq?=
 =?us-ascii?Q?GXLrioZM5Gc6K78jZKMHPkpdGj89K+U/w20BiLqoqMdBXh500SxtnG6eT75X?=
 =?us-ascii?Q?q4s/GOVylXpDhWd7BDocgR6EpauypyrVU9pX/a6ssSnQHz09QEsEjZ9gco16?=
 =?us-ascii?Q?p8J8/0QlnBIdCOlUsCM6o/ekk8PID8UlrHiaCrkNBDhf+ysTf5XqRJMbtNU7?=
 =?us-ascii?Q?PYXXFWSDTtW2InQ35oeKTL0r3R1mXebJb2kjpd04i34eby6kW25omVsU8x4y?=
 =?us-ascii?Q?gNBCtRldyecA0Y8Y25JEHb48Hsm0fAoyKWPF9iUgpCcpMpN9MWxtysF2zJkW?=
 =?us-ascii?Q?Jc/d4JVHWziYppz01mFIV8g3/JRE60Hra+QOqbzdb9NCMsMCdLGffqfxn24U?=
 =?us-ascii?Q?C9g45zB5W14FcP2NRmkPXCSL3DqMu+jfEVOu5FyshrbT8csdLLZkUOtw/xCk?=
 =?us-ascii?Q?w4GZyzmmlS3LIz88GNUkjt4SrfQKW+br56U9grXNZY4t9Rq9aUbf6EFoaFrr?=
 =?us-ascii?Q?vGOzeehnEsszWaEVWUuVf2eLfNSuhvlW5JJtKm4E6HEKf3wlwbV7h8dglXeQ?=
 =?us-ascii?Q?vTJYbUEYlBgIMOZzuCHWEOX85rCPrzrZug5bF2RMDvmsjU+MfHl3+Mi46twI?=
 =?us-ascii?Q?SJoVisvwpo5gG8ugiJrYMZINWrPckGlYG7/r7Wlh89/Hp/C/ma1iLKIYX7ld?=
 =?us-ascii?Q?v3GTECZIzhvY95Zn5yBQOooyBlPsHH2X1onkGnIWQZT1octYd0Wbu/mDmIwd?=
 =?us-ascii?Q?3f5b+pnyZ7D0byWmYrMsT6He9LDP+6FFTyvDmDnOHltd/vGg0g99GbISG1Ww?=
 =?us-ascii?Q?gpB4EsoXSyxL6KBh1t/UL3UaTt/Cm+6cr6Kt7oXfUF/Q8uHeib00Jbuz73HX?=
 =?us-ascii?Q?3iC6yzRWQuzJ3V4RyjhADWpPqitLgBwTsxqx8oKbCfb181CJ9nWxmlx2VXpq?=
 =?us-ascii?Q?6XOt5b2fed3rOqUF16WQ57LnruxJjfFmzXdTTuUjfSri0zHBwE1R1CMSQlcK?=
 =?us-ascii?Q?t0RdC/qxdSxxtiWwW2M0yIu+lzA0fEPCn/S674WCKsNjCYNfQMWFL3F20I2s?=
 =?us-ascii?Q?+MslkHZQSQGyvSNdv+IF+A4NEWc7zeTwBTxb8VwkesCsL9vp4wn7WSQYCjPj?=
 =?us-ascii?Q?lxYb5C1ECcj2K9FVpf1/ZuktTNX52wAYBJmQHWof7JophikCl0YKFDTJC0s2?=
 =?us-ascii?Q?5zEXbq+z5MAFHAoSIcnRE2E1JFl5/73qMGD4EVPt1BlwnFTuUJXXNufkCq2M?=
 =?us-ascii?Q?XxfN6E9faY519WsgkvKrA3T58kFW6eHmB1LJw7w7qdRV90Ey8TKb4P1wEWkF?=
 =?us-ascii?Q?3v5MLO5GJGcere4noHG0HBZGmeuxg5pPLviZu9cUZ0UNZiugA1/slGwx6Xt2?=
 =?us-ascii?Q?ohWLtIpLG2xksanddjXB7HgNZYvTZp7jeQmMKA3rfjHCDFiG2lIK2Y7tS5wT?=
 =?us-ascii?Q?+6Yfn3+7dRkHDchUNcOVdOh5EfqdfQLCfvm9sptCZSDYry1gWGg+cadEhg+L?=
 =?us-ascii?Q?3TTqZmqywYAzO/ULIUdJTBBTPNvpMMLG9y0Ee34BTq3gAlVeTCZ+1MSZ3Yp7?=
 =?us-ascii?Q?PmOcXFbx0Te+gUhz/+1nbgckN1Eqxmhm4FXwmXOU/EHQVkeRZ981+UPSXuJI?=
 =?us-ascii?Q?IoSk5VWrn1AGKFWwmsZ2dVeUCd6LkuB05yGSpoJcDO6YG36Fsh4/9bSbE6Nz?=
 =?us-ascii?Q?Ch9HjPRqeaRs93Rz9SGJacnfB1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f573aae4-8a8e-480e-fc87-08d9b666a84c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 14:10:28.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +obslkYMR1Q5yJzgX/r7+MdZciH5xi0fjtQcCUGYbzNVTZTBgi44aSewpDfMJM7Zn+q6+SSgLp6iSMkaMI7P/d6oZ9Zc6IeYi/VgbJgb3vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030086
X-Proofpoint-GUID: ZmOrcoYFmtKb_Nslhtkf1tJlrxA2iNzQ
X-Proofpoint-ORIG-GUID: ZmOrcoYFmtKb_Nslhtkf1tJlrxA2iNzQ
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=4.0 tests=AWL,BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
Subject: drivers/net/can/usb/peak_usb/pcan_usb.c:523 pcan_usb_decode_error()
 error: we previously assumed 'cf' could be null (see line 503)
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: c11dcee758302702a83c6e85e4c4c3d9af42d2b3 can: peak_usb: pcan_usb_decode_error(): upgrade handling of bus state changes
config: x86_64-randconfig-m001-20211202 (https://download.01.org/0day-ci/archive/20211202/202112021833.wABxM5UN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/can/usb/peak_usb/pcan_usb.c:523 pcan_usb_decode_error() error: we previously assumed 'cf' could be null (see line 503)

vim +/cf +523 drivers/net/can/usb/peak_usb/pcan_usb.c

46be265d338833 Stephane Grosjean 2012-03-02  450  static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
46be265d338833 Stephane Grosjean 2012-03-02  451  				 u8 status_len)
46be265d338833 Stephane Grosjean 2012-03-02  452  {
46be265d338833 Stephane Grosjean 2012-03-02  453  	struct sk_buff *skb;
46be265d338833 Stephane Grosjean 2012-03-02  454  	struct can_frame *cf;
c11dcee7583027 Stephane Grosjean 2021-07-15  455  	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
46be265d338833 Stephane Grosjean 2012-03-02  456  
46be265d338833 Stephane Grosjean 2012-03-02  457  	/* ignore this error until 1st ts received */
46be265d338833 Stephane Grosjean 2012-03-02  458  	if (n == PCAN_USB_ERROR_QOVR)
46be265d338833 Stephane Grosjean 2012-03-02  459  		if (!mc->pdev->time_ref.tick_count)
46be265d338833 Stephane Grosjean 2012-03-02  460  			return 0;
46be265d338833 Stephane Grosjean 2012-03-02  461  
c11dcee7583027 Stephane Grosjean 2021-07-15  462  	/* allocate an skb to store the error frame */
c11dcee7583027 Stephane Grosjean 2021-07-15  463  	skb = alloc_can_err_skb(mc->netdev, &cf);
46be265d338833 Stephane Grosjean 2012-03-02  464  
c11dcee7583027 Stephane Grosjean 2021-07-15  465  	if (n & PCAN_USB_ERROR_RXQOVR) {
c11dcee7583027 Stephane Grosjean 2021-07-15  466  		/* data overrun interrupt */
c11dcee7583027 Stephane Grosjean 2021-07-15  467  		netdev_dbg(mc->netdev, "data overrun interrupt\n");
c11dcee7583027 Stephane Grosjean 2021-07-15  468  		mc->netdev->stats.rx_over_errors++;
c11dcee7583027 Stephane Grosjean 2021-07-15  469  		mc->netdev->stats.rx_errors++;
c11dcee7583027 Stephane Grosjean 2021-07-15  470  		if (cf) {

Check for NULL

c11dcee7583027 Stephane Grosjean 2021-07-15  471  			cf->can_id |= CAN_ERR_CRTL;
c11dcee7583027 Stephane Grosjean 2021-07-15  472  			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
46be265d338833 Stephane Grosjean 2012-03-02  473  		}
46be265d338833 Stephane Grosjean 2012-03-02  474  	}
46be265d338833 Stephane Grosjean 2012-03-02  475  
c11dcee7583027 Stephane Grosjean 2021-07-15  476  	if (n & PCAN_USB_ERROR_TXQFULL)
c11dcee7583027 Stephane Grosjean 2021-07-15  477  		netdev_dbg(mc->netdev, "device Tx queue full)\n");
c11dcee7583027 Stephane Grosjean 2021-07-15  478  
46be265d338833 Stephane Grosjean 2012-03-02  479  	if (n & PCAN_USB_ERROR_BUS_OFF) {
46be265d338833 Stephane Grosjean 2012-03-02  480  		new_state = CAN_STATE_BUS_OFF;
c11dcee7583027 Stephane Grosjean 2021-07-15  481  	} else if (n & PCAN_USB_ERROR_BUS_HEAVY) {
c11dcee7583027 Stephane Grosjean 2021-07-15  482  		new_state = ((mc->pdev->bec.txerr >= 128) ||
c11dcee7583027 Stephane Grosjean 2021-07-15  483  			     (mc->pdev->bec.rxerr >= 128)) ?
c11dcee7583027 Stephane Grosjean 2021-07-15  484  				CAN_STATE_ERROR_PASSIVE :
c11dcee7583027 Stephane Grosjean 2021-07-15  485  				CAN_STATE_ERROR_WARNING;
c11dcee7583027 Stephane Grosjean 2021-07-15  486  	} else {
c11dcee7583027 Stephane Grosjean 2021-07-15  487  		new_state = CAN_STATE_ERROR_ACTIVE;
46be265d338833 Stephane Grosjean 2012-03-02  488  	}
46be265d338833 Stephane Grosjean 2012-03-02  489  
c11dcee7583027 Stephane Grosjean 2021-07-15  490  	/* handle change of state */
c11dcee7583027 Stephane Grosjean 2021-07-15  491  	if (new_state != mc->pdev->dev.can.state) {
c11dcee7583027 Stephane Grosjean 2021-07-15  492  		enum can_state tx_state =
c11dcee7583027 Stephane Grosjean 2021-07-15  493  			(mc->pdev->bec.txerr >= mc->pdev->bec.rxerr) ?
c11dcee7583027 Stephane Grosjean 2021-07-15  494  				new_state : 0;
c11dcee7583027 Stephane Grosjean 2021-07-15  495  		enum can_state rx_state =
c11dcee7583027 Stephane Grosjean 2021-07-15  496  			(mc->pdev->bec.txerr <= mc->pdev->bec.rxerr) ?
c11dcee7583027 Stephane Grosjean 2021-07-15  497  				new_state : 0;
46be265d338833 Stephane Grosjean 2012-03-02  498  
c11dcee7583027 Stephane Grosjean 2021-07-15  499  		can_change_state(mc->netdev, cf, tx_state, rx_state);
46be265d338833 Stephane Grosjean 2012-03-02  500  
c11dcee7583027 Stephane Grosjean 2021-07-15  501  		if (new_state == CAN_STATE_BUS_OFF) {
46be265d338833 Stephane Grosjean 2012-03-02  502  			can_bus_off(mc->netdev);
c11dcee7583027 Stephane Grosjean 2021-07-15 @503  		} else if (cf && (cf->can_id & CAN_ERR_CRTL)) {

Check for NULL

c11dcee7583027 Stephane Grosjean 2021-07-15  504  			/* Supply TX/RX error counters in case of
c11dcee7583027 Stephane Grosjean 2021-07-15  505  			 * controller error.
c11dcee7583027 Stephane Grosjean 2021-07-15  506  			 */
ea8b33bde76c8f Stephane Grosjean 2019-12-06  507  			cf->data[6] = mc->pdev->bec.txerr;
ea8b33bde76c8f Stephane Grosjean 2019-12-06  508  			cf->data[7] = mc->pdev->bec.rxerr;
ea8b33bde76c8f Stephane Grosjean 2019-12-06  509  		}
46be265d338833 Stephane Grosjean 2012-03-02  510  	}
46be265d338833 Stephane Grosjean 2012-03-02  511  
c11dcee7583027 Stephane Grosjean 2021-07-15  512  	if (!skb)
c11dcee7583027 Stephane Grosjean 2021-07-15  513  		return -ENOMEM;
46be265d338833 Stephane Grosjean 2012-03-02  514  
46be265d338833 Stephane Grosjean 2012-03-02  515  	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
c9faaa09e2a133 Oliver Hartkopp   2012-11-21  516  		struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
c9faaa09e2a133 Oliver Hartkopp   2012-11-21  517  
d5888a1e75c799 Arnd Bergmann     2017-11-03  518  		peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16,
d5888a1e75c799 Arnd Bergmann     2017-11-03  519  				     &hwts->hwtstamp);
46be265d338833 Stephane Grosjean 2012-03-02  520  	}
46be265d338833 Stephane Grosjean 2012-03-02  521  
46be265d338833 Stephane Grosjean 2012-03-02  522  	mc->netdev->stats.rx_packets++;
c7b74967799b1a Oliver Hartkopp   2020-11-20 @523  	mc->netdev->stats.rx_bytes += cf->len;
                                                                                      ^^^^^^^^
No check for NULL.

1c0ee046957648 Marc Kleine-Budde 2015-07-11  524  	netif_rx(skb);
46be265d338833 Stephane Grosjean 2012-03-02  525  
46be265d338833 Stephane Grosjean 2012-03-02  526  	return 0;
46be265d338833 Stephane Grosjean 2012-03-02  527  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


