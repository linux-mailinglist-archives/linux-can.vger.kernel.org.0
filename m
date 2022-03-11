Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9C4D6077
	for <lists+linux-can@lfdr.de>; Fri, 11 Mar 2022 12:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbiCKLSC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Mar 2022 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344290AbiCKLSC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Mar 2022 06:18:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1131BA913
        for <linux-can@vger.kernel.org>; Fri, 11 Mar 2022 03:16:59 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BAU6Ha032732;
        Fri, 11 Mar 2022 11:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tRFsTL5TmSRwjDJPmTZF3t+j4ARZlzuKl/BpTLfVHkU=;
 b=KSLhaoBbiEUkRTWG134m536KjGozTUCgl1877P5yfgAcoYuTimQ4S/toyqlPM6yxTrxO
 yIB//OIjgYjNuDUz7b8+Xs6D5Jf20aUL8PEnCazDuDiBDPK/jSxF7HRKMdHrHAPPEEAT
 3O4LWw68WBBnOIe0JyT26ESysc2WaP8+mgnC9NkcklXyP4rpzniTvEt48roqoJBrkB5v
 4JnJObX/u9jBRWBUkl3bHY2qRdYqeLhOAK5KSvUgteZ261QZPjwhPcuoWtXz+hZBKBfR
 OwOQwdfM4WSS5fZlfx+rkJdFpVK+ujI0ovAnpz/2ErLMFCZr7EMBIcReUKXaODnecZNY mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2ru5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:16:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BB6JKZ166243;
        Fri, 11 Mar 2022 11:16:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 3envvp311g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTbidpkDgQR0/u0z0vokWuAc0T0Od/zEM1ntLOlAg32xFvE1+P0T1Gsd7tnDNuGVv/PrTLVV6CsABqlyo7RV0vQlf650qRwwozwS73r6DntEU/sFHlA6OEN2gS1Sk7RjQwSpoGS+q4sEvsHfJq5IUNzyLzoNHAWJXNGjZqp5RYQSh7FgkbKPkyXmwemTc6EbmO3f01SDOpG+7kii1JWKSzRljsGT08ojX78p0s+ar1+lwg/ACAJhQN2y7pMB59SNHvDiRUjmMABVDB6ZrJnf9JP45BQk1wyPJQrhom8kGr4dJwq9aYBHHzJ/JvCoprswr/+iF//jSM1skrcroAUsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRFsTL5TmSRwjDJPmTZF3t+j4ARZlzuKl/BpTLfVHkU=;
 b=LRwPVjkm77NqKrBqrvo/EAbRnVWBXSEqL5mI7iGaJ+0kWsl369fAXiaoDscWpuMfI3bJguJp5aqX11daNvbXmQxNzwxAlHn2/Jm+7tqprzmSaP5teuAEYOVNI6iPEMA6op+roKeTGBzCQFaORP6PFDVj3XS6Eyh7Ukm+t/qEWP3q4Nn/xbFuZ7tARMAxn4ZHad+ZpU95Xfrci8RGQisXksldafipgfZa8PeNIkyI25lWr3fkjo+W6Bkiz30ZY6Q2zB9K9Kz2TqUsfoZcMHjZ7xZUIVd1/h+ogV1d8kADulpFVCxR0yaH84jgHVww0ACBUfubaHdzT8SUjLeK47hxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRFsTL5TmSRwjDJPmTZF3t+j4ARZlzuKl/BpTLfVHkU=;
 b=Zhzaw1UB0NT0D3Dx3qbiN+NSzWd3GER7am7PK8vJJOYa7NIDkSIQAt+WprRbSTE8fu9QT3RhXwUFzSWj4enPxGZ2YMI+ImHGgLmcjOiDj5IukUmgHWDZ+8J2JHygzY5Hs/JtPBdqpSq7Ogozh+nVFCfBr928nApkFkUO9SU8zas=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4493.namprd10.prod.outlook.com
 (2603:10b6:a03:2dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 11:16:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 11:16:44 +0000
Date:   Fri, 11 Mar 2022 14:16:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [mkl-can-next:testing 4/29] drivers/net/can/vxcan.c:60 vxcan_xmit()
 error: use kfree_skb() here instead of kfree(oskb)
Message-ID: <202203110433.qIHMpuS5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc012f8-9065-43f7-dc22-08da03509fc1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4493:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44939D45BC3A750E3E037A208E0C9@SJ0PR10MB4493.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxQo9t121hLfAIMIi/jYaliXjKmkX7ZFmATLDUt8gRvvLDzonai6skfDyJb3LjofoK+WxLtJzr7v7oaysa3uX0JhTu9zDcBadGYvJ6CYXJEKwYSPnfXr/QSr63daEg1Gb3s0Wqc0fwclxCtq/etpi2jGtcKV3ppADxiaqgdzuxog224lfrkIpiI7u5FACdILTR+XJFaOIJmxNLTrntg/FxDhJLhAZIaBGrsydxy0/UW2jvbrKWHxfkVvT7RB1DIujvxBtI6u4/qS/+MceSaFIvUwb8enk0p2VV36vTczvpBXOteCiphaJnWluHfuhpgIivjWiWWbDjliEkKv2m15xpag3You69fXixkkEDlHhTCXFMYEWHp1ed0rufSTIepEfprvR0xooa9i5huLYR8JCilXErAz8zcxhGoSq1wLXp08sFj1fKOPAH3/S7ShoEDi7QdqdcqKMWvbn/F5yhoRw+9ScCX26GwCVoKuCzwn35z+MNIVIr0jIWvAWTdI2IyZaoZUpFiwfid5NhnGdi8wWma7jgVnNvzspyIbvrCdG62oHB2zkl7lPnDSYDR01jJuZSvYGb/L8ciXVpYjReSYxgKRIdDnC1gt4dEt8/0YmzXp34zGfMzs5rDVukueeHnNi0tCsLwQkR2F32zoaukyFx+Y8NsklP3Ef6BzkS+oYnwZ7QlWOGVfP2zE6ZqG8OyAGHZOPsq6hlSc+gBGRti8MsSo3AFIH0P+lN43RXpR1H2FSaQGfK/36hHYR7vBYns2JThtPuxM34/LavTaCmqogzZDAPlCCpr7rPiyckvu8iP4xDi6Mj4N3nGju7OnCeaMliGfwV9HDfDIpj5DL/3J9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(44832011)(5660300002)(52116002)(6512007)(9686003)(66476007)(66556008)(66946007)(8676002)(36756003)(4326008)(2906002)(6916009)(316002)(38350700002)(38100700002)(86362001)(966005)(6486002)(1076003)(26005)(186003)(83380400001)(508600001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2dZKhjKyG7uRkvTKF0E1vSlJeb8xybGSj/4/+OSSQHLv0mReS1qd5HQ4E8d?=
 =?us-ascii?Q?NDyr4zFVO5t4BCxJjwD8TNV82wFuiXU/4wbr7SUAv6Q3MPhVWsibRG69glZy?=
 =?us-ascii?Q?6RaXvCXRaqkfYDd74xq0OAltvdDU0vcxnEvCOMowpBPNevyUjD7sB9VIKRm7?=
 =?us-ascii?Q?bGa/Fa8PxLH8XvT4bcJZyxpFGY8DVKX0iePOvopFThUVhJIzYjeYFLsbllJ7?=
 =?us-ascii?Q?qpl6tyDr0hqciTUqZUlJqHoeHeeAZxBaR89fUvVmX9/oQ/L6PWeghzNWDI5+?=
 =?us-ascii?Q?My6TOzWecf5SadakbZYegd6E/PkOsHC4CtS8Gqz3s6TpIyYfYd8h80E0kIZC?=
 =?us-ascii?Q?hFM9DTHGB777A8CPWnlPp1KoS4Oy6OH0y3tmB9Y9Vb9STYn8ztcvRD68p6XJ?=
 =?us-ascii?Q?JKj1b3ufUswZKIFmwuFEdslnWktcPaOZUVg3atMNfzeNV49zd/xKwGY908di?=
 =?us-ascii?Q?NOUqDBUqIyp32uv6Wim14EgTe0JwN3mPDrY2R+I6t6DTdgpgBkzrZxth7Qhd?=
 =?us-ascii?Q?MLVRdoJ/bSvGfr46UwQH6mVrnAjIznH+Z4LR2aWFSvIDz8UUF3XvgznmMtOY?=
 =?us-ascii?Q?Lej7O9aMQGxXuhjYhCcKfL2CTbyx6njP0QLPKVp7WBSdO9Pq99Cp5AzkHfDt?=
 =?us-ascii?Q?tUaCBlzHtsOgU1LtD5EoN33RAEgb7/RqDA9doeV+gsMKYtTvkGkH3jok3BTg?=
 =?us-ascii?Q?fFbCOiuiLos2nonXJnLXKITrqOCaGjKnj+Maxyn4DIWN5pdRHLh77wf7wvko?=
 =?us-ascii?Q?AEsa7MsoEFOc8A1b+FmlE5bC12uiHDkogHAAVWex3W9dpp4kolsO8/urPPS6?=
 =?us-ascii?Q?zSBhuZmZrHyO0xz02GMnfTgGgZhhA6fX9BU9fF/rATgcX6sClW4ndBoyGBPO?=
 =?us-ascii?Q?7No3HK1G4pnh2T2kH2e+OOol0WvgXd3PAFjuDFCsLvxM3ln+ZfQuHLdkBM5k?=
 =?us-ascii?Q?fJplR/l0N7b760T3HrNqK6INEEO2kcXJvzUvlBGej4vKfou2vjQB6brZefca?=
 =?us-ascii?Q?Ue/v4IsjOmmPu4+JchqkO06i6vEThfO4OtCjSo9/jS7QIqFoA1y0ZrOpsMGi?=
 =?us-ascii?Q?RFXvh+mvaKJ1zcZTfRaBWbiJHXDl77IEk+urU64IcgnqnHqzUcQGwdO8Trul?=
 =?us-ascii?Q?BiI8HNeEBlsoEqx/n4CQuJmzj0U3mHvnTWiSkDMcnsfS2hIi5oAYAOA/JEU6?=
 =?us-ascii?Q?kw+AXwKwXLheiGbGViJA3AzFG9Dp0KgwuIwj3d1NTYDARuGgIag6EcIZb1SB?=
 =?us-ascii?Q?P9iZuVkK6VJKGk9sNHpka+5S42UgIKpnyNJh/nbfDscTe8ZFLAzzyy37dKG5?=
 =?us-ascii?Q?+1q0CHR4zfuK8nkzPfX05jSp2Mt6qndcYfkuce2r2VQtcqCzdoRKp18dYjZc?=
 =?us-ascii?Q?UUpX0uRI+8QaE3iDwdKSdeJp5yUfb4/eS7i5pyncIr2wA+vkaiPnP6d48SPH?=
 =?us-ascii?Q?Ztp38Mx5kaGit8Fm88Q1Z6W/dE09sNMbXtCeBOp5kBSvPGboEt4MYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc012f8-9065-43f7-dc22-08da03509fc1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 11:16:44.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBp1gZuu66SAzQbCgZBSl3dUisJbaIIc29tJHy9W30NNjTesY3FDgtPFJsKBLfxqIPsIs3PgccUhCfO1kf78G2pm5EMO9rIl93l5+P/Cx5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110054
X-Proofpoint-ORIG-GUID: rYpjMjT6yD34C07QcCS29SVxYi4Zi-3H
X-Proofpoint-GUID: rYpjMjT6yD34C07QcCS29SVxYi4Zi-3H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
head:   0691a4b55c89055c1efb61a7696f4bc6aa5cf630
commit: 1574481bb3de11c9d44f5405c17e948b76794f39 [4/29] vxcan: remove sk reference in peer skb
config: arc-randconfig-m031-20220310 (https://download.01.org/0day-ci/archive/20220311/202203110433.qIHMpuS5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/can/vxcan.c:60 vxcan_xmit() error: use kfree_skb() here instead of kfree(oskb)

vim +60 drivers/net/can/vxcan.c

1574481bb3de11 Oliver Hartkopp           2022-03-09  36  static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  37  {
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  38  	struct vxcan_priv *priv = netdev_priv(dev);
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  39  	struct net_device *peer;
1574481bb3de11 Oliver Hartkopp           2022-03-09  40  	struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  41  	struct net_device_stats *peerstats, *srcstats = &dev->stats;
1574481bb3de11 Oliver Hartkopp           2022-03-09  42  	struct sk_buff *skb;
75854cad5d8097 Vincent Mailhol           2021-01-20  43  	u8 len;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  44  
1574481bb3de11 Oliver Hartkopp           2022-03-09  45  	if (can_dropped_invalid_skb(dev, oskb))
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  46  		return NETDEV_TX_OK;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  47  
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  48  	rcu_read_lock();
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  49  	peer = rcu_dereference(priv->peer);
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  50  	if (unlikely(!peer)) {
1574481bb3de11 Oliver Hartkopp           2022-03-09  51  		kfree_skb(oskb);
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  52  		dev->stats.tx_dropped++;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  53  		goto out_unlock;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  54  	}
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  55  
1574481bb3de11 Oliver Hartkopp           2022-03-09  56  	skb = skb_clone(oskb, GFP_ATOMIC);
1574481bb3de11 Oliver Hartkopp           2022-03-09  57  	if (skb) {
1574481bb3de11 Oliver Hartkopp           2022-03-09  58  		consume_skb(oskb);
1574481bb3de11 Oliver Hartkopp           2022-03-09  59  	} else {
1574481bb3de11 Oliver Hartkopp           2022-03-09 @60  		kfree(oskb);

kfree_skb(oskb);

a8f820a380a2a0 Oliver Hartkopp           2017-04-25  61  		goto out_unlock;
1574481bb3de11 Oliver Hartkopp           2022-03-09  62  	}
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  63  
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  64  	/* reset CAN GW hop counter */
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  65  	skb->csum_start = 0;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  66  	skb->pkt_type   = PACKET_BROADCAST;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  67  	skb->dev        = peer;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  68  	skb->ip_summed  = CHECKSUM_UNNECESSARY;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  69  
cc4b08c31b5c51 Vincent Mailhol           2021-12-07  70  	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
00f4a0afb7eafd Sebastian Andrzej Siewior 2022-03-05  71  	if (netif_rx(skb) == NET_RX_SUCCESS) {
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  72  		srcstats->tx_packets++;
75854cad5d8097 Vincent Mailhol           2021-01-20  73  		srcstats->tx_bytes += len;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  74  		peerstats = &peer->stats;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  75  		peerstats->rx_packets++;
75854cad5d8097 Vincent Mailhol           2021-01-20  76  		peerstats->rx_bytes += len;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  77  	}
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  78  
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  79  out_unlock:
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  80  	rcu_read_unlock();
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  81  	return NETDEV_TX_OK;
a8f820a380a2a0 Oliver Hartkopp           2017-04-25  82  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

