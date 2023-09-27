Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD57AF954
	for <lists+linux-can@lfdr.de>; Wed, 27 Sep 2023 06:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjI0EZW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Sep 2023 00:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjI0EXu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Sep 2023 00:23:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E92704
        for <linux-can@vger.kernel.org>; Tue, 26 Sep 2023 20:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/k3xI3fFlfR5iFAuYoPItnOerDmoeIAiRpyHZBgN2pT9k9W/ONi081fRvPsNSHkk8kl74ijML5HO0HBb4ea1FRV7m/3TLepUjOJ3KoNKkzD9CS87OdstNskkkFaL/+Ai+mx+vfHAMmtRgdfBRAXJlUn4Eh3mER0snui9UYgl6pjjl3CcYM2gWAZ6y3j6Z91zBAkKzqQM3vMz7Of4IV14Kyuu4VuxoTTp+zmdT0N3E2749kTk5d1Jz4ErCWrZtJo/1lKpsxNjCQ6dXns4QVsUJyeiClsSgMAi7I+8Pxzx5G1dszb8JU3Qn/ApICzEMJi7WrKn9S7X5p41WZbmlexCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6+i9xI/N1josUF7C/1gd2mvjGb/8gzX+L9kuSJ/Szs=;
 b=jFLGuLHNLp4cnRxC952AWLhxQKyEHiDPlYnT5XP4Zf7dKU3v7Fw41Wqfr92VjdBmwSz6qgujDj4uA/VNAlUwub7M7y96m0IYJjILWLEyBqd8TLUgsOmZw/EeEQMh1PRbag5M4op0Nsim2juALJrFr1SPRMpzd/+DuEeGW8+bfClzow3dqVGN0+Gni49CG5G+CKJf2cjAdkDkV9EKd91LpPleMgIChF79buUBIC/KLzude//FLywMEsBaL4+olnec/kF/18LPzwErp+sX/HAMCW8+4KTeMLeMRP8osoWNm+EwdK/ff3m+B5cRz5rrbrmw9al+NY/Qx7R0a7HCLHMqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=limntech.com; dmarc=pass action=none header.from=limntech.com;
 dkim=pass header.d=limntech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=limntech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6+i9xI/N1josUF7C/1gd2mvjGb/8gzX+L9kuSJ/Szs=;
 b=n90fjORvUx5gnmQ+XYoHsgCRyg4YeszNBOEOZX/2plA8EmgxF0AwPV7VtmZoy62zLbet+XsSSXo7do0KIPeGWI/q05ZhZAhqdpQM3J7xLPokKBYrcvOWij/kYQ6VCjPc3NJJG9Yflxhg8XhnnXlyi/H1Zi4KefdClyhI7KHbYSIbClWey9T121YwK2yZTLs0EHi9aK0k/aDNJZl/Jh70BuB9bihags9E8G7RB2NoTKBCPYPtwzcO0wnAiqdSUlhDNd2XjQMTXeE67mEbHBG7gX+iFaEb1Bx6Ouv1T2OsI96h2gf1/RhlzfGpF0WbzgxXtwYGTtE253S1/nQoOzSbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=limntech.com;
Received: from MN2PR15MB3727.namprd15.prod.outlook.com (2603:10b6:208:1bb::24)
 by PH7PR15MB5939.namprd15.prod.outlook.com (2603:10b6:510:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 03:11:01 +0000
Received: from MN2PR15MB3727.namprd15.prod.outlook.com
 ([fe80::b1d3:8c2e:735f:ee4c]) by MN2PR15MB3727.namprd15.prod.outlook.com
 ([fe80::b1d3:8c2e:735f:ee4c%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 03:11:00 +0000
Message-ID: <20bd5abf-5d0f-86a5-4774-a8ba33d6ca1b@limntech.com>
Date:   Tue, 26 Sep 2023 23:10:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     linux-can@vger.kernel.org
Cc:     marm@hms-networks.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        socketcan@hms-networks.de, Florian Ferg <flfe@hms-networks.de>,
        Peter Seiderer <ps.report@gmx.net>
From:   Eric Stahl <ericstahl@limntech.com>
Subject: IXXAT CAN-IB2XX drivers
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0468.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::23) To MN2PR15MB3727.namprd15.prod.outlook.com
 (2603:10b6:208:1bb::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB3727:EE_|PH7PR15MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5634ce-1e8f-4bde-f366-08dbbf076042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OH2VPL5P1OtEWlhmX46pS4a9/DAOGcF6HAHr2857e74KqDqlTiQRbm4n75gNPesxj3yt1zAODGMuHgffQ5Zh8uIiumVGI55gLMgiusJ5jjvnuoPvieN5OBPc0DZwgmRvjWK009P+UoXH50IoZAxqWgbrgIv6qsew9iJ5eIuY7W9HroSb3tYmvr4H85Yk508d2kWAUTSfA3THbttopP95WfegQzsZ8A8Wb4ZheVVZstMQR2AOjxJpebV5/YS3ol6S1aq4vtz/LyJaz+cXpmAMwEa4RllbczXuRx+YjtveEMpx8GbXZFzbIT997HkTn1ZJaS4obUSdqoWap1W+nARp7GjKB3LMpMM/2jdKjdCyEdfYS8fVU6Xla7ks+kKolzzIb1uictGLHsNcMXt4bAov/IDVpLi377wtLK9BG8vQ8fWQ4QRlSauO3zx9tt+v+eahV5F+RmT92yGh2mtr60Awub6cjF+YcREMJlStoVc7EQtOTh8+0zEsXkpnDILqXOdfnaLkG4L3SpLjqlFD6agbqPb3T1VCJESICV1PZnbX6oLyKHn4sBpo99YxRICKhlrqgEFJQwgO51KBVJWhSN90vRoD2UX9O4Vlz9hSLe84Hz8FJkpsTDYT4XAJJ8pquILrlcQ86o/1uubg+/W03yWLrRQQ7cPfI6COQnH/tQhewmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3727.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39830400003)(376002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(36756003)(86362001)(31696002)(31686004)(5660300002)(26005)(52116002)(6512007)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(2906002)(6916009)(41300700001)(316002)(4326008)(478600001)(8676002)(8936002)(6666004)(38350700002)(6506007)(38100700002)(83380400001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFI1YnlmbXZwSllSMG1XaDBVN25mNWl1bUdWUVBNeW1ySmVncGRDTzg0L2d2?=
 =?utf-8?B?YVdJZmVsbnpQZjB3Mm5ZVHUyWXVETDJ2SWk4Vk9lb2k0dk1WeGE3RmN4cW4v?=
 =?utf-8?B?OXI2dEdMNytJMGpxbVNtMERjNER0MGgrMWZqYlhxNWRGRmh2V3M5WXpneUc2?=
 =?utf-8?B?TXM5dFNkSWhNMU5FZzFLWmx0cU0vbTExbExHYTVZZWs2S2llYloybk55bG42?=
 =?utf-8?B?dDNrbU4waWczZ2wrbG8wL1picEZiaTZkdGhQT1k0dy82NkNpSTBhWG9MaWZl?=
 =?utf-8?B?YXpla3RFYmdJd2dsNklLUnUwWUdiZ2RMVmVvZVZBcThnY1F4Q0cxRVRSemVj?=
 =?utf-8?B?d0hvUVpuc3FPa2ozNVlnMzRzQ2FSaWtaSWg5TDlvQ2ZBUDl2aSt0VkRxcFBP?=
 =?utf-8?B?eWhSMnpUdmVsUnBLeDljVEF2aWZFQUpiMWp2OGRTT1VhdVMvODBYTVNzYy9D?=
 =?utf-8?B?NWhVS3RUeklDcmlMaG5CalZ6YW45a2pJSXlhYkxwUUNSejFRVDVkUk5meXlv?=
 =?utf-8?B?WURBZ0Mrc25JL1MyVy82MzJqdnI5ellHeXdIbmVNaFRKcDhhUEo3WW5Uek1X?=
 =?utf-8?B?cU5zYkJyUEZtOGMzSktJUlMzWEVJR3U4L3BIT2hKdThMbWxaUFB2YnRkUDdM?=
 =?utf-8?B?cGJFZWdha3pQc1RNanYxOUlHRGhmc0pyU09wckRwNnE5bElEWWg0bTZ0QXl0?=
 =?utf-8?B?RWNucFZWRVk4M3g3N0JHMnBzSFN4SVkvdHh3VHE1TzdRRjFSRFJYRjY5ZmJm?=
 =?utf-8?B?NDFZR1JrMUZHbkIyV1NxSzluSFVNOWxtV05pb3RwNUd6b2FiWEFxck9hbVRq?=
 =?utf-8?B?SjFNSFZ3bHNlSmtreWt3MUJJUE5Fbm15Nm9JKzIyQ0lzNXBGMlVYcmJNY3ZE?=
 =?utf-8?B?aEdndDF1QXhObFhPL3l1WldZSnY2N2V1c2poMzg3TkU1dGJWSFNGaVFKWlF0?=
 =?utf-8?B?VHlSbHRVaXpaWWtIVjRVSmtmY2FXUFVlclBSL0NWSHN6VFJLSmxNL1hTcld3?=
 =?utf-8?B?R1ZjTi9IYmJLZ3FlOVdhbEl3aU5NS1hVRk5BMnlwbHFvRW51ckVLbHdtajJR?=
 =?utf-8?B?WCtmSDg2Mkd4TWdYRE9VSERvOVdTMkM0SzVNK0JMc1V6c2VjRWh2RTNZdlFL?=
 =?utf-8?B?blM4eWYzYldTbDJWN0pxYnMwWUp6WDFaK0Y3dlR4bGxpRnJSR0dqMldJMU5q?=
 =?utf-8?B?MEQyWWNocE1nM2d5YlVEK0N5cGlrMkNuLzZEdVQ2OXB5YWd2TWJ4REthQVg0?=
 =?utf-8?B?WGQyMkczUERrUC8rVnVoWmc5amZBZXpIK2xwS2R3VzRhby9ibWdtSVNKSXl5?=
 =?utf-8?B?ZS9MK3JIakh2MWkyRk0vb3JOcTJpaXQvNXlrcmcxRDlRU0xCdUpHK1ZnT05u?=
 =?utf-8?B?U0t4dldKNW1aSlZ6OXF1SlNSK1ZHUitGR01jZG9Jb1VKR29mTnpyTDlaRzdP?=
 =?utf-8?B?QmJEV0diZmFsQUpxbk9nRXdqVmpWYjJ3eC9sT0o5K3lSZWtNaU02aWFEbkVE?=
 =?utf-8?B?c1pxakVFRWtuNW9DN1dPWG9SNURVeEtoeVpUY1FSUGZJZnZhc1lEakFGQXFZ?=
 =?utf-8?B?YVpIS2s5UEU5T2gySEtZcFcxNkJGbWN4dk9jcCtyV3NFazBLb1QydVhTa25V?=
 =?utf-8?B?bDZ3ZHpFQzhWTFRPSUlnRXErYXAvNkNWMnY5TDlETHZGSHNZY1JRTkNrQTJ6?=
 =?utf-8?B?aXVFOU1YclFGRkVGZnZxRTBkMmdCaU5pUnR3RjFkN2xkNDhFZElxNmxaUkJU?=
 =?utf-8?B?cW42K0orTTVXQk9RbGdUd0E5SGwvMXkxOUx3czlScjBDSHAxYTBHQmZIbENW?=
 =?utf-8?B?dWVZWm50a2dZeDVrSkpVYys0aFJJYS85YU54UDFsbUd4V0d5ODY5NElpekk2?=
 =?utf-8?B?R1pqK3ByZGk3Y0dtdWhXRVhFcGlUaGRNeUp1ZkpCUmhWbyttc1A1eW1xRFVC?=
 =?utf-8?B?V0JGSFdicUdPTW81UjhoVVp6RVIraEpQdFVjM2UxL0dwc3ZOdk1zcmQ4amhq?=
 =?utf-8?B?b00xNURseHpocEpEcVR1bDlkZzZpbzRMK1RRQUtrU2JnT2c3NzA2Sk9TL1R2?=
 =?utf-8?B?c2FJcnVCYjlGbmF3NUdPUDRMK1oyYUQveVJTT01CL3BmMll1RkluUFFrWFJj?=
 =?utf-8?Q?8IkAhCUaF1DyXptHYnraP2SEy?=
X-OriginatorOrg: limntech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5634ce-1e8f-4bde-f366-08dbbf076042
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3727.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 03:11:00.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9ae210fb-cbd6-4b9a-bbf2-a375f08b4179
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovOAAOV6xxBSiJRJ13j4TwUa18tNGMmftDeWMWTo8YpHK7Ojv1pOVsWealbQtjGZpZQzbZgm6IgZYYjbi65hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I was beginning to familiarize myself with the ix_active_can drivers for 
IXXAT CAN-IB2XX pci/pcie boards in an attempt to get IXXAT pci/pcie 
drivers into the kernel. I noticed that the device driver distributed by 
HMS 
(https://www.ixxat.com/docs/librariesprovider8/ixxat-english-new/pc-can-interfaces/linux-drivers/socketcan-linux.tgz) 
appears to be using the IFI CAN/CANFD core. There already appears to be 
a kernel driver (ifi_canfd_plat_driver) that leverages the IFI CAN/CANFD 
core. Should I continue to try to get the ix_active_can drivers into the 
kernel or should I try to leverage the existing ifi_canfd_plat_driver? 
If I should leverage the ifi_canfd_plat_driver, what approach should I 
take to get it compatible with the IXXAT pci/pcie cards?

Thanks,

Eric

