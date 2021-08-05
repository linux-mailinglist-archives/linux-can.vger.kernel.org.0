Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E83E140E
	for <lists+linux-can@lfdr.de>; Thu,  5 Aug 2021 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhHELqI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Aug 2021 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHELqI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Aug 2021 07:46:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14694C061765
        for <linux-can@vger.kernel.org>; Thu,  5 Aug 2021 04:45:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mBbou-0002KR-EK
        for linux-can@vger.kernel.org; Thu, 05 Aug 2021 13:45:52 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:68e7:ca3:e3f1:364e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 60C86661361
        for <linux-can@vger.kernel.org>; Thu,  5 Aug 2021 11:45:51 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id WC8HIS/KC2GjcQAAs6a69A
        (envelope-from <dan.carpenter@oracle.com>)
        for <mkl-all@blackshift.org>; Thu, 05 Aug 2021 11:23:27 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6C11C66133F
        for <mkl-all@blackshift.org>; Thu,  5 Aug 2021 11:23:27 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 40C9566133E
        for <ptx@kleine-budde.de>; Thu,  5 Aug 2021 11:23:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dan.carpenter@oracle.com>)
        id 1mBbTA-000087-Jy
        for mkl@pengutronix.de; Thu, 05 Aug 2021 13:23:26 +0200
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175BDXRI020558;
        Thu, 5 Aug 2021 11:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QEnrp4B04skE/eeU6Y9VLhhlT+xwocO9a0G2DiRDePc=;
 b=eYqa4NFByEKXUiNsxCEPDmHm0ZTYjase3Tx5d0kVUovoeQoqd/GwTT6q4WQvPHk/G4PQ
 /lZnpv7L5ic0iIhiZy3e6H1/1BzS0v/To7rawurHuAGMTFTY6M+ZJ1wwd5sbrBfEla6m
 CiiXQdOhEUdKxHoEnRGWlXDzl0j4kAKbFYwGsd53/rz92ttVpSmoxRIkVn23dCK9E3ND
 mGluPRLfHQruHOCZLmFBvSHWlMJdWyQJvqYMLF2yqWbd5NbORzsjvD9XLUTMC/u8TJym
 Hs9/eLgeYQTCFoy00wp2BsI5EWaBRPRymfOzb+cntYNdYKBTtUIOYFWzpBIa81Tf+Zbx dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=QEnrp4B04skE/eeU6Y9VLhhlT+xwocO9a0G2DiRDePc=;
 b=DAlf1CgPX/XPOqh/VWx9ub5fIMwnh6Pd48ZHXcAi/JED/xEApRuzhBRoy3GSPZDXSNgh
 bedsEaKoCqJpB83BLz+uRGTAP/lEc+FwzC8dBDQQd0+W5Yi1m8lgJqABCnlbvbkX9aF2
 ogrzTHPunb/ap0lUNf5A9Mjsi/08Dc6KlJAZaJZkvQkv51+GZsbWMg0dYFrtfSzkdYwL
 xvXuPauXVTxPcfBIE7cJfFcOhyWdeSaE0+5EzIpLQWEYaG+FFAWs0QX/ZbKa9SrVmdAC
 mfwxydvrQO3Y/FF7Ag98PYAnE5/qJfqb5MS/OQZLXentyB6A3YtojH9xbw34F79lg3u8 wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn401y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:23:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175BBYXt068931;
        Thu, 5 Aug 2021 11:23:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3a4un3k210-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvlydraDUR94VLkoRumiNVq+n27xNWDvQKbk6Y+p1dzVPRSWWY13fyLXAwYYPEs6x/Fx9eohIrg3FnnSA95gsOpOOSNJX9FwmJj76gq+hOEGr3LpBUJMYJ4jZT4yHVF/JZyO/aLQvlW92mCMmKQ8gQiVxGJooYpl8zPyvz3rZRfKA2hrMvreTiN7c70zLxZzCZ38lob4urPpDoqFKVBMlLLQxACPg/ChagSZ4giRcom6EgYJQp1TwGO8o378PQQ1UOmTkURd5NxyDFTrcxXZLUUbbcuP/dvhCK7x6t6d5b2FpAXpXfy81yauecmxOLxDkk03rMCr0DllLwNM7cgfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEnrp4B04skE/eeU6Y9VLhhlT+xwocO9a0G2DiRDePc=;
 b=dfZ/WGQWEupvOLXE8GVZ05RdtUTTxMsj/dqciijaANwP7/LULDsj2iEzzvkPQ3K/T0+lVjS6Zyf6wfWt05GYfFhohEGXvBcDOrtXP3Trgw/JKbAN+YxCIGC5m81UhdTjLu1rglPzVKsuOaZWIvDFJ4htjruyrUj3JjEqiUhgKqsVKXJk7CWE7BjvFn7bP8LFIcMsP+V654KFfjDCrx05LVziDfP16RHuQT5a8gAzcVXWGy3MbOQVwlHeK48Sd5k7TY0q43dd3ol70IpprPt6yteBFdZzFirvg5QOBM3ZWoWPiqAFdEGK5j0rsm8phnxRIWu4oAVDSbgafAXuHwLNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEnrp4B04skE/eeU6Y9VLhhlT+xwocO9a0G2DiRDePc=;
 b=oOJLMkXfP2Ua1hTVqRmnLy7g+yGBdDRIgL2e3yfVoWWOOOWB1LJUf770QxBXdQGK+3Mg03RnIWtQlvG83uWXfI1aeG237i7Cn9CEbHmFFT8ZMmcZFLgbYzgeKuj+ZaAJ5xZYgcQvnNci9P9cLpVWSUBlmf80Bekmx6o+v9fhmEM=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 11:22:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 11:22:51 +0000
Date:   Thu, 5 Aug 2021 14:22:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Angelo Dureghello <angelo@kernel-space.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <202108050850.IaTFXHsB-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 11:22:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9257f4b-fc9e-49db-15d0-08d958035c51
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23653D48F5136A2CEED397B28EF29@MWHPR1001MB2365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQhfYltRVXDQkcDwlmpt5tJ7jQ+ILSDAlmQkZe6sxg0sRZJv/rMPQ0ipvVKRxeWGxjfYGxiXTWMcJHXsTTc9nDuloeRWp8UlbFRFEscfIBg/aSabw728omZWss5LcirwPFe6d+MW8SXne0KORI+T6pgxUBrrNZUBaA/g9SOIZpnElj7zs5U50L0DAAkUswT55ytsEstfATUPA5db0ZnJgkrNPPt5R19LM3B0Lxz3+LOcciivDMXFe9SDYq3Jzy7rUCeFdEeG+VyMQerRDmOcXohSYZv6CKbZSj9ayWUm5QIzFNfIXUshACcq/UfVstevTxA74C6Dcgi5L2cXDX/ya/oc6Ou6eBtgH6GG4SQoLPejhtFc2XYzEIvX396fAKnePUiyj4mJ6OAqEJcDzNR798iPtdo2Ibl66q10libcED+sSsWlpfLXo9CHJse1esuwePMOvX0UwZ/ov97TVcB2sx3CaCIDwS+yxUkbQ91lubP3rmOJ1nI1nRuUIyKT0vgI1q30rOUJ48kHKPeFx9LCZFGDXpVBapZl6zsLdo7w46bCtFrBRdykZqS6uk+9OCNEVN10YQER45oDgNqttGAYiZBDViAxGn3MrcnWkFd2Ad1iLGFiWtzGwNIFBNAJzXVgalgxMB1LYY+JQF/VqgF/RT5trUH6iriEie9is0v2YquXmQHQVHOWOder6zNjMWPRTof6rFgy5DkuCDhX+PUsthylBf0yUIDi9aLplfaISxB3HQAMIkWmSvGWqywXLkf6+Ijht0j/E3UPkHamV25AHHVa23mU8+Stxa5aZCbtnxDe7U/rO1+qWdWt44kkkOvO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66476007)(966005)(4326008)(66946007)(1076003)(66556008)(83380400001)(44832011)(478600001)(38350700002)(38100700002)(9686003)(5660300002)(6666004)(86362001)(8936002)(26005)(4001150100001)(956004)(8676002)(186003)(36756003)(6916009)(6486002)(2906002)(316002)(6496006)(54906003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bq4LB8kqqmlf99jtawjMzJmTMCmMrLeL+vhMKY+T7nFSkb2q/zLbZmN+L80w?=
 =?us-ascii?Q?5QHL06rziwQs4iv12mjD0OiCKGRzBobsBXX8R0xs+FliPtRZV7RO0UxyqeSv?=
 =?us-ascii?Q?S0kby6PCAmq3oV/0ux80/dSfT3vAlWhA9jzw6WSa+169JtwyUpfanE5XYJHj?=
 =?us-ascii?Q?gvXyyb5K5UnLAWI3Yj71dEdkZygt8VSj9GjMg2r6hi72w1+REFXgI1SzavYo?=
 =?us-ascii?Q?/8Txyxlg3L6ecPHORxKSwRKKhFRpuiyr3ma0a8BiTgM8me0MUVD0wCb/w8Pp?=
 =?us-ascii?Q?1tLjaCPVUbv2tjYTuya2T5pAWlcu5LeseozsBFfKU1UfMvBcKu3GZ8AsbUb5?=
 =?us-ascii?Q?rayW3uzvp03p/cQQe81JMyZSbWak2AXmVjOqCX97eFaT9TVNl5bowC7WTXLG?=
 =?us-ascii?Q?lTaxByrfK1Ic6ox8a56NZUUKXuOhiTPeDMMoveZh2O75Kv7LQdfMFG3421qL?=
 =?us-ascii?Q?R2U9jZvsD+pgeiKuUUfUEG5zUdx6NzP2jjua4f9DzjP4oLSVW7vKQq0qwjRK?=
 =?us-ascii?Q?pEuh9QvN15/Gk2/f/Jea3fEONWbOZjs8+4DTwYLNHxWy2ygrV32NLngBVuf7?=
 =?us-ascii?Q?cEeBMrfNrP091xazdpwRkiAlK8jUBV3vD15zSTJlcePMenttNLIUr+7iYWl1?=
 =?us-ascii?Q?ETyG091mroZAt5UAXdQnLld333H4fRipKgphTSDd0RRZHGMFyrfD0gQUpKCH?=
 =?us-ascii?Q?c5FKXRUDEzIrnGutQBT2BFFz2F5sS/6z2Z6nDeshGnKjuPH88DUWUHBKdOOc?=
 =?us-ascii?Q?oN2Nwt2pF9zEaj/V20OOQshl4hzDyKHmir5pC7xUld1S1W0l0sqsK3yv1aWo?=
 =?us-ascii?Q?PfyzSxRYDbQmq7TpbCkKKbRSh7PYzYaFwdV/bMLWJr6i+pH+LJ1eB+EwdFxI?=
 =?us-ascii?Q?mnOs2gh2iiD0SNhnXiLEFpZMrybOwjmQKqRlkp6sooJI6QXkysVC01VJmS/1?=
 =?us-ascii?Q?HqI4po6ETFhwdbUBdhlwNTGHZuuWkGgG0bKgLmjOqmYyh/c5ksIdZFZZVsJ1?=
 =?us-ascii?Q?Ut/DNl4ToPSSVt+l42OBgFomwliaYEg8BmFKfo24dej/+3o8D/JW6h7kVQs7?=
 =?us-ascii?Q?pbI0kQfN0Hc3m5DTKWZVVZXFTzn30xMqU7VsI79F4JGq2Od6jyOkQBunPiic?=
 =?us-ascii?Q?EZJZ6EYYd3AQZfYew4kxi82VawxT8eiN+4iAv7NryZxbEoo3yAn//BMfnUYm?=
 =?us-ascii?Q?LaBv901NH410yP71yjhxpLkmJxTm7NKlubfs0P2mAAFsEu9w7xhhfoZhwEl+?=
 =?us-ascii?Q?8m229mew2vFmyQwUzKKvWJzIcjb2iVGg2mo55QmxoUjjs+lINVd+BWsOXzjb?=
 =?us-ascii?Q?f8FLoxAoIjxz+7cChpsAZoZ2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9257f4b-fc9e-49db-15d0-08d958035c51
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 11:22:51.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xP6+Ey+4+YVedYu/NPGymscGuER6TK/6LeGFpLFDoJyIgbCzGsWy8Sw4k1Kb7mkXfzUPkNubvGNmlmpywN6rb7XJtfgZnxVgGbdFKx55uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050068
X-Proofpoint-GUID: 2LdFhDhccYYNwEE8e11InyCWAjXK1XQK
X-Proofpoint-ORIG-GUID: 2LdFhDhccYYNwEE8e11InyCWAjXK1XQK
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=4.0 tests=AWL,BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [linux-next:master 2764/5318] drivers/net/can/flexcan.c:666
 flexcan_clks_enable() error: uninitialized symbol 'err'.
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   2f73937c9aa561e2082839bc1a8efaac75d6e244
commit: d9cead75b1c66b4660b4f87ff339234042d7c6a5 [2764/5318] can: flexcan: add mcf5441x support
config: h8300-randconfig-m031-20210804 (attached as .config)
compiler: h8300-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/can/flexcan.c:666 flexcan_clks_enable() error: uninitialized symbol 'err'.

vim +/err +666 drivers/net/can/flexcan.c

ca10989632d882 Aisheng Dong             2018-11-30  650  static int flexcan_clks_enable(const struct flexcan_priv *priv)
ca10989632d882 Aisheng Dong             2018-11-30  651  {
ca10989632d882 Aisheng Dong             2018-11-30  652  	int err;
ca10989632d882 Aisheng Dong             2018-11-30  653  
d9cead75b1c66b Angelo Dureghello        2021-07-02  654  	if (priv->clk_ipg) {
ca10989632d882 Aisheng Dong             2018-11-30  655  		err = clk_prepare_enable(priv->clk_ipg);
ca10989632d882 Aisheng Dong             2018-11-30  656  		if (err)
ca10989632d882 Aisheng Dong             2018-11-30  657  			return err;
d9cead75b1c66b Angelo Dureghello        2021-07-02  658  	}
ca10989632d882 Aisheng Dong             2018-11-30  659  
d9cead75b1c66b Angelo Dureghello        2021-07-02  660  	if (priv->clk_per) {
ca10989632d882 Aisheng Dong             2018-11-30  661  		err = clk_prepare_enable(priv->clk_per);
ca10989632d882 Aisheng Dong             2018-11-30  662  		if (err)
ca10989632d882 Aisheng Dong             2018-11-30  663  			clk_disable_unprepare(priv->clk_ipg);
d9cead75b1c66b Angelo Dureghello        2021-07-02  664  	}

Smatch is complaining that both priv->clk_ipg and priv->clk_per can be
false...  Probably impossible in real life.

ca10989632d882 Aisheng Dong             2018-11-30  665  
ca10989632d882 Aisheng Dong             2018-11-30 @666  	return err;
ca10989632d882 Aisheng Dong             2018-11-30  667  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


