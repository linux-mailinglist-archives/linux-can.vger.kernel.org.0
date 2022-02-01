Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED54A5DDF
	for <lists+linux-can@lfdr.de>; Tue,  1 Feb 2022 15:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiBAOEH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Feb 2022 09:04:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57224 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237314AbiBAOEG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Feb 2022 09:04:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211DOO56011241;
        Tue, 1 Feb 2022 14:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=C4PHjtetcBSHTv6ikSMojRlw1v1u8mwJdmADTMBXXWw=;
 b=RdM0FSWFoMkH2rCdmassKSowC5rBLhnYoUsQXYlmHbORW+7a5riNY0YdqecG2popub0w
 PMPoTQA5nT9ozJV74tMdj28qx8ksttwFMuVRMbnuKyD6VZLePVdLvbVYfF/jYWnftcDv
 24xB6+s5+gmUNPlbu5R5arvpcqbxpcvmdrVpHQdTbfHET3EWu62vPtIsLYchMYbnRmDX
 CR/nc2WCXyoaG+utgfLpy1y1YEZkmnp8x/DoFx5za/Y7+ptYfgPw/0pDh2nXGGf7TpR9
 FEnWYrrvT5bPt2A++mGGc6wDBLH8GB8U6ve6lbptYXQtcWGG8oDKtpkGEtHtZmjExRJB RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac2ywr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 14:04:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211E1e7H047633;
        Tue, 1 Feb 2022 14:04:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3dvumfg6v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 14:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEqn8qH2uzOX9RP/1Ek1oSW/m/Sm7Of4mOm1s5LmCXiIaupG5EIGPMsZ8c1FOEtrkzw3jaIQ2eDMx+EPc2DMEVaIRQFrT5EWivKjw/Y5CivQbwGFLzDlT7TAAnZiaKFab37Uh1ZKeC1V/XMSizCOeU8YXHPInJ2YzVbjrq+cVD7q5pGxpbFwreQCKnFTJNjA0Zw6hdyJkN82yzK7fHJ5mP2lkRz4sJUImD8dn+ewS5lLeLWx3ayUf7SFC9dJ1e4O8YAuazLKGopIMCXtwvrquGLxnZjhLiEN3SrS/l74QbMO/CMLAfnBTwJ55a+z7RzqMqRnmhjI1+qgxku7y/FrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4PHjtetcBSHTv6ikSMojRlw1v1u8mwJdmADTMBXXWw=;
 b=KMiLje94dUNT67I/a8Fq15bReRC/CVaE3Z6NUAJru6FuIucSfNy781oXLlDeo7OCT/hQtYrqHJY48/IfxJM+3/Qf62dT6DWEk3lj32qDtIf6LYzk+vby6NmGy6C/P6EC6525kP9/++KkSlVocCKDsk7eCvSo2tN6ltD/LPuACxh6Dr0gnPpDqAa3B1usm32uNQyVUNv71V3D/XlXiBibUYZsCkNE6TrIxT9Aoh72qK2uXPQMT7qP7F94G40sNn2R5KM6MAx5b+flo/S2a0hc4IZcxHXCu0b5pTjitz42brm0jWSVnaKWjHqQEg17ceAVIdKBjeYE71jYxgMMZWi4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4PHjtetcBSHTv6ikSMojRlw1v1u8mwJdmADTMBXXWw=;
 b=KnuYmQ/uJuJ72uSntQ6SnM8gBUx+L8c5DTlwHg7f/CAA3VGgDLgYqh+m73LIOz/ZFb3+ymPz0HNmximd4i4RsZ0fea0ibHBH8Txel0LUz9hrkdYpM+cbOyq1qOTrOH9Yz1G8M0eA9pCrJV1rZ39BFy40Rvnmruepq7XHYlfJGNI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3893.namprd10.prod.outlook.com
 (2603:10b6:610:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 14:04:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 14:04:02 +0000
Date:   Tue, 1 Feb 2022 17:03:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
Subject: [bug report] can: etas_es58x: add core support for ETAS ES58X CAN
 USB interfaces
Message-ID: <20220201140351.GA2548@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211b7102-ed6d-49e7-3b44-08d9e58bb30f
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB38934CEDB4191551BD305EC28E269@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No1Ju2MvBMjbe1yHiL4Iypok/rwofgjtcK4rcZU/eTQRZ9vJ/N1qFeC9SK+Ni072TRw+5SJsEGjToH6lXwidateYDOHoJIdOr8SBdgFXrpbn7p7cmeZh4qVA5chcVQXtRtow2I1bgqFwWS4kbHDtH4IMZidrRPL3MZwMpjumdQ4aAWUhbAKXSCJxCl5z9yHSml9i/gNb9Ncd9TlS2+C4p21sIz3FqYjS/+HAWcUE5cIYJbg9qv4JiqARZGFsOt1w+uAyC0og1KE9cQpv2fHzY6nWR8Me4xOC2KIcgaHGvSml1mj7ktiFc6OI8Dr/4IArqEVhWpO/EiW96LNmcidsdxAxSUFyhrJBM6XiJ5p/5AfDMO13r31CHcyGgiVSre++Z9jTHegr7HY7rNgXA6gKxL6oGK5bkguRouuIhP5I1s/ZSRDhl7zqGgiD0UJLjYvhMEgibOSzz7XfVegTvgl0Td8AB+dPMktz1dBvuB0akE71kdoJ7Sh7/po1F4YZtPqKYe4tBBNov+R3m9R1na68T0OlgzXqe0fN/pqE2ntIZR0ZgB+t3IpffaFaHFktutNVAM8l+V9UBkFQJeiZbEIC8t1C6xLats1MxKhyP6NEKFylRwjD2Lmkkj04dTi/vd7ig/mr3Q5N2QOpGg2Ezvh4udPwsGKngAh7vG2O9MQG/FX2jb6Otpow3cwWK2HBY+LYEWTjqm0gHIHl4IothiYEKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(6506007)(9686003)(6512007)(44832011)(316002)(5660300002)(508600001)(186003)(6916009)(1076003)(52116002)(6486002)(26005)(33656002)(2906002)(86362001)(8676002)(4326008)(66556008)(8936002)(38100700002)(83380400001)(33716001)(38350700002)(66476007)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DB7EktHwLLZKEhlgbbYfGw6Xk4r4rTg4Q4aeaP8BH6SEwBb3d9ROr9NwnjIv?=
 =?us-ascii?Q?IYFphUbiRgjrcdT6wia0Qu2Rlt+RVhIQcq7CNxsrh9wGM3rDupVzBCQkQxmP?=
 =?us-ascii?Q?8iLdGVjmHdPs9U/THhuw0cABqWh6oZ10d5LnJyF4DlKvO6yQ3Jo09OUmBrmC?=
 =?us-ascii?Q?RLL19V9TqchSK9KZSxcJ87hUZ7RXEpgEBE/bWXpAqctRiaR+l5y+Q8xPbk2u?=
 =?us-ascii?Q?I4YT6YTx+7cHUDbAE69QX9YJr2NirttqguuW7DbwAjY+5W+wlNqBOxeGckWq?=
 =?us-ascii?Q?Vi7DHBIqXJWN5D3lFoBKXmHPlF2hK5vDcLqU30t+F7c0AATlnC8VsNlp/LlA?=
 =?us-ascii?Q?XRQfGYeqhRebC8I5DP/okN7B7xgGECo5LtqFvsXIqMrLmBuhNnYak4e42tYA?=
 =?us-ascii?Q?TtiqcepuwKeL6C7BgAm3a2h/f3clFJYsn97rMGXYLwBsy2yTkao8rnkkIXtS?=
 =?us-ascii?Q?2vDD1lTTC1iiph3jte2KNnw49/zUZVZk4l144qofRhjVKjhRJNBlYM/9Xo1x?=
 =?us-ascii?Q?dcekbcCiQQxgR/BsDzzTXl6IsZWhpCQ+TF6Txs4aa6mSlkNExV/UOC4zCJkZ?=
 =?us-ascii?Q?OmNzUkqJ3yZ6kTjhZF+kMahPcF0ouziksLJFwa8metcJlE3yYaL0VQUWkEqi?=
 =?us-ascii?Q?VD1rCi3X6Cjo2B+5wSYUCa58IngbDkfSQvgin0wfqFIapwfKM+FS8LScJSX3?=
 =?us-ascii?Q?XDxteSG80gAkkwjVuYWYsljkLhB5evuIrmobGWsJFxvLm2qCL+wizKSBcWCy?=
 =?us-ascii?Q?JGE970sQvTckb86TivtlLMH5Ia22oCBKOJ3vUdOE9eOEptp06XRIfHRMnf8X?=
 =?us-ascii?Q?OKSy7aOrhMVZMBGS48C8i18jzND759G9IlWMZpCm5xLAxDucmYEt1xbGYbaH?=
 =?us-ascii?Q?uvm1kpPntFxrgmSweMUkoYb/uprsx3u9g3V2ivLs4LbWSAEpPvl0vwEjcsKB?=
 =?us-ascii?Q?hwZH6AukeVsmTqKSx3j7bpzrNcRsvV3fNVWnekCDJcthvixQ4vf821WqdQod?=
 =?us-ascii?Q?Uk11rhnHIPmCA4uRrL9aIGN5MNcfXgfH7OnKxf9rIoyLQQmC2pRfh/hUUtBO?=
 =?us-ascii?Q?AFTXsL5p68SPCKz8SLe0/a3OlEHrgtsF726LtsGNnDYZnRUt0L8W/fZCj0Pw?=
 =?us-ascii?Q?QfnTUOqTFMBWHHx1JrNhrVsccxt0EBs/5t2PyFfIZSrDNOpF9gVbsInTxdny?=
 =?us-ascii?Q?MNtmIUAJoCCBy+eQxhdG9b1RkEd6Muf58KDHR5VSxDJ7tNOUWssjxILco3Zi?=
 =?us-ascii?Q?jB3Yw16Rwif9um7LUqKGniZ2AYZfTQmhLJIUXzOyH0PO2gTT4ffK5VEcMqnB?=
 =?us-ascii?Q?EHdNMO6bI9SzQi5erpWvugV00CPDmOn7tzYO4IKuZh9ArD7CVlkuU+l6pGlC?=
 =?us-ascii?Q?1sTgFFb+EJK/dvWJ+bA7IHLd9S8fmUCtFhg1xcy279HAJW7EiVuIXwE+uloA?=
 =?us-ascii?Q?xUzpU+z9IXnSb5FbET82njARmAVZ+6SmRMpj1AfZKEylyX8V2gxexgJs6oDf?=
 =?us-ascii?Q?oD8nQTGW+7VCJhLpBbXrdzNBCbeTasnyXFV1VzgieyCQc7bAHOhrPEOcjobN?=
 =?us-ascii?Q?icwpwAbyhuNWGwZKzab1i37ii/GOWQFNZZBFbGc/jLF/B80f8hbT2EcwkC7D?=
 =?us-ascii?Q?tWrnxBJ9BZeMFOVj9xu/RgmCgqT2dhF+n0us/24G3lVaiADgm2SD/JwoPruV?=
 =?us-ascii?Q?ooi+gOT8ase/1oAKPJeElcORyts=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211b7102-ed6d-49e7-3b44-08d9e58bb30f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:04:02.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DUQzz8jalQ6CQuQ7xmHp7VEGeeWtDu/JDWvihrgP15V3INQrVGVIVwO0R2moREMaTsLMdoMO33KSuVy31ZKUhZeSQP3Q/nWG1zB0hxkkQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010078
X-Proofpoint-GUID: JjwWoZAAz6YPanKOiaWwgd4qeYkuFL0m
X-Proofpoint-ORIG-GUID: JjwWoZAAz6YPanKOiaWwgd4qeYkuFL0m
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Vincent Mailhol,

The patch 8537257874e9: "can: etas_es58x: add core support for ETAS
ES58X CAN USB interfaces" from Apr 10, 2021, leads to the following
Smatch static checker warning:

drivers/net/can/usb/etas_es58x/es58x_core.c:1818 es58x_open()
warn: inconsistent refcounting 'es58x_dev->opened_channel_cnt.counter':
  inc on: 1793
  dec on: 1818

drivers/net/can/usb/etas_es58x/es58x_core.c
    1785 static int es58x_open(struct net_device *netdev)
    1786 {
    1787         struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
    1788         int ret;
    1789 
    1790         if (atomic_inc_return(&es58x_dev->opened_channel_cnt) == 1) {
    1791                 ret = es58x_alloc_rx_urbs(es58x_dev);
    1792                 if (ret)
    1793                         return ret;
                                 ^^^^^^^^^^^
This error path should decrement &es58x_dev->opened_channel_cnt back to
zero?

    1794 
    1795                 ret = es58x_set_realtime_diff_ns(es58x_dev);
    1796                 if (ret)
    1797                         goto free_urbs;
    1798         }
    1799 
    1800         ret = open_candev(netdev);
    1801         if (ret)
    1802                 goto free_urbs;
    1803 
    1804         ret = es58x_dev->ops->enable_channel(es58x_priv(netdev));
    1805         if (ret)
    1806                 goto free_urbs;
    1807 
    1808         netif_start_queue(netdev);
    1809 
    1810         return ret;
    1811 
    1812  free_urbs:
    1813         if (atomic_dec_and_test(&es58x_dev->opened_channel_cnt))
    1814                 es58x_free_urbs(es58x_dev);
    1815         netdev_err(netdev, "%s: Could not open the network device: %pe\n",
    1816                    __func__, ERR_PTR(ret));
    1817 
--> 1818         return ret;
    1819 }

regards,
dan carpenter
