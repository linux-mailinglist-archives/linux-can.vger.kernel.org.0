Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3636992F5
	for <lists+linux-can@lfdr.de>; Thu, 16 Feb 2023 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBPLTL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Feb 2023 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBPLTJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Feb 2023 06:19:09 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E263A0BC
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2023 03:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOXSSBzv36zIha/LtT6J1I2yO/xaCD6rqsNUkLJPNdPEZpKL5v9uY4KMCGS2ZPuNCxC4JZlEh+bm0scVD7HU4/KTgbWo7MKGukkw/pAcYl+r/LxOG67rpzsmD9/8tbIEXjRXNlVxfN7ZsEDqanJXcM4oSZ/gsXl5CYP8dAKtqFPoeya81mnR4uBFWhlxQyxIPR2/uqnuJHecvfgsVz+iFc7bCH/ycsVlqXiqTsVJRD+7MoQNgkrf9Tsz57Oe29ahy5rBqGywJjDv5EjmO57uSzFxXOXCudKmSDfUDI/QI95hYOWAS7lBBLaWQ6ynnNB5fBd0+Q6tugrZDQfAZpAUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFzq4wSuaaILpnS73s3YxO95UVtuWngppDTPCrMuAP0=;
 b=EqN5IGxHV49fBKpzsvGWMi8niAg+3rKwAsqdOn2mR05e6xtYtBcIclUVt3teMD4qkFdM5+mVx8gpsWFe8lfhW1cvCS1sPcOQUc2g8LNLiP3w4cu6kVLKn4RR6UkaXSlSQJ2ZhiMGLekGCxU/ZayYmV++iqieVTv0C92DjSXNJEDij+ggRit+e9LY7S6CrTrkIOM7fvDhsXdpnVZzFcDwjfrwez6QSZJmayXk/6zpCZUI2ylYviAQFlOK3KXNdFCzN21hpF+GlsChojzlF2PEazQyTzhDEJt4NHwlEp73MiNBSWLzaI9gFELhjubCfye38G4lqkGA24fdykZHqyJ1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hartkopp.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFzq4wSuaaILpnS73s3YxO95UVtuWngppDTPCrMuAP0=;
 b=Sgr3UxaBMgtSFtvVmykfVCkYsq2xhzLIKcBZY5Ll35oU8wKIZtq01ec2MOF0XXMZg7IVe1a6IK1UJNqmUlIErGgF+0I40QpZuYIndxCCLZXB9yLCSWU8/kAJuBuc27uSM36/TTuXul8J0T8lmF345i2lZMgBnRVlI5+tyLSRTxg=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 11:19:06 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::33) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 11:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 11:19:02 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 05:19:00 -0600
Message-ID: <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
Date:   Thu, 16 Feb 2023 12:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: xlinix_can: bug when sending two RTR frames
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <hsweeten@visionengravers.com>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
 <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6192be1c-fbb1-4d6d-7012-08db100f9bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2StFIWcS+sRFd87CaID3yCLO4wR9AMejcnU2ekAj0Fjui0csaUdTzVrxj4ueVNu2HbEJ7w/C7AN05WhZyPDO0+yrtGtoMid1RfBj+BESn73QpdISlJaIeVk8lD2AlwCRGHECgC+OFzuhUWML7FgBtJi4YVT4TIhkwPkHP0uE4sSLb2rDywFP4mFKfO6hfbtfXKL/s8Z7O9S95y5n8nNJ0jaLe9z30sokalsjDs3TuasvwUB8bZi4MMOB8nH9QLpsYbhtUl/yzafe57WLW2mSNbAr/4NKX0mi+1fP92tQwMUej3B52wtZPhVLp0RRNnDRxbd4LJtngikIYUzQ8dbVlgLFF0JkN9UZSvSSIgFmNwmwi/zaLHrqZjccY4KYylwHUP1xMU5MLcumFSr+hAW/EJcWzcWgGfXmTtQMhllKYsEuRgd36l+3yG2IMmAMpkpexfwMxcw7LDOAwdVwKTZ65MBjXyi+mM2D5TMJ7DhG0TC0cF+47u78CpaL+SqR9zgqzMnWzdmblwWNZQ3Xloi/zESo9KCad7MVCiro4R/6OrlT2c3Bp6iMnMrOtOm1SDjfyvsSuVhfQAkZecgWe9z3K6LdhBiVT8HD6cFmiS0o6qsXzwRD9xKh2l1DPu9Nh/MMInPozD14FROwMr0Nt9pw01cmSXqn9/vQhNpTE35gYB3qNeieE6/D27CiyvzrHCYgVRG4YlTqpPRogKDoPmT1qpf9k70cOe0aALY5x6GwmGXFf5HIL6k/Ok+k9/HBo3aq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(426003)(2616005)(336012)(54906003)(47076005)(966005)(82740400003)(356005)(81166007)(36860700001)(44832011)(2906002)(82310400005)(86362001)(41300700001)(6666004)(53546011)(16526019)(186003)(8936002)(31696002)(26005)(110136005)(16576012)(31686004)(8676002)(70206006)(70586007)(4326008)(40480700001)(478600001)(5660300002)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:19:02.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6192be1c-fbb1-4d6d-7012-08db100f9bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 2/9/23 18:53, Oliver Hartkopp wrote:
> 
> + Michael Simek
> 
> Missed Michael when checking the responsible people with
> scripts/get_maintainer.pl
> 
> Best regards,
> Oliver
> 
> On 2/7/23 21:45, Oliver Hartkopp wrote:
>> Hi xilinx_can maintainers,
>>
>> Hartley Sweeten reported a bug when sending RTR frames with the
>> xilinx_can driver here:
>>
>> https://github.com/linux-can/can-utils/issues/405#
>>
>> The problem: When sending a single RTR frame (e.g. with 'cansend can0
>> 001#R') nothing happens.
>>
>> Only after sending a *second* RTR frame with 'cansend can0 001#R' the
>> two (pending) RTR-frames are sent directly after each other.
>>
>> This faulty behavior of RTR frame sending is independent of the time gap
>> between the two cansend attempts.

I read that thread and I am missing details about Zynq board.
Are you using any custom zynq board or any xilinx standard evaluation board?

Can you please c&p dt fragment you use?

You are using 5.4 kernel which is quite old. Can you please switch to the latest 
upstream or 5.15 xilinx?

Thanks,
Michal


