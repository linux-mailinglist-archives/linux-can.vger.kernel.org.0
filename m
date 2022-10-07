Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843525F7D7C
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJGSqk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGSqj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 14:46:39 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20104.outbound.protection.outlook.com [40.107.2.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D793B970
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 11:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGEO8bkt2R5ZKdRrxS+ZxHvzxjFxUMvyFIn/SmVfceyRQKm78DXIBqxQrpfCtBBbapfsuYr+InKpXr4WU4iEMznnHtvoDIDg/BbMlFYw7J9faY3NF7HPyWS1ITWEr7lTrwklCmW3+Hx/JW+zPg8rxHesiAyZVPfDEvv8NB7NyCiYXwdo4LGkD74YTPksf0nbHWsCcFkMpI85kPV09xbPltpm6NAm4ecLMFN9kCLoE+ZfFehC5DpC2dmiibL4hbEc/o5tDytUjhBq10W89q73NK7XAtw63GDIBv/Qi9isC4GlYnjHPqofbt35W5oumxZ5akM5AYuiioDX+PchV9iYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8HYBO0ho1tuRqLMZcuF9UqQKDj5xmanjB4OnC5HJ3w=;
 b=Yfw2YRnuDTNc6uccfbcJA3T/7Sdi6IfJw6p7wYoO7ixruJZb6P2uMQ8wCdb6NEvt0msya1mm1l4i9BzjnyL3jr9p5lkwpl88eiy/tAQ/WWvB8vXSemVk1vUgruvpP+zZkfCd51l+jjw4miIoJ5IgwI2PujkGFQVOj3EI3hgW3KT2ff5rPB44q8uZeaC6dQ9Xw3CmwR2Z9I2YLFZF6IcyaEUStEUhcAQmD6Bn0nFx5zo/xMF/Ra5UoO2FaKFAZViGSggEwgaPWnZBgi8Mm7H3IfCIx6ByxQp+31zFjSgVjiBXP46ah/0IA5aML2SWKuVCQQ/Ym2809hWcuIoKBggwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8HYBO0ho1tuRqLMZcuF9UqQKDj5xmanjB4OnC5HJ3w=;
 b=D00grKaQPRtw92QHMKcFqKpKu34tJMkGzI7T+UkX0H9dqBPMfOmeWWGTDRpIr5Idl1xa4DJfj6yFI7IWNDIKkAl8sPaeAcjSwF4AopJ1mvWvCsfS82cuk3RegqR+jWxqmuCc04s1ngWYJbvrzmOoO3fDoJb+V3JEN4vitrrf4TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by AM0PR07MB6370.eurprd07.prod.outlook.com (2603:10a6:20b:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Fri, 7 Oct
 2022 18:46:35 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6%5]) with mapi id 15.20.5723.011; Fri, 7 Oct 2022
 18:46:35 +0000
Message-ID: <7539f462-d183-289b-e993-046d878a1fde@victronenergy.com>
Date:   Fri, 7 Oct 2022 20:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/6] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE,
 GS_CAN_FEATURE_BERR_REPORTING
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20221006162452.200322-1-mkl@pengutronix.de>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20221006162452.200322-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0120.eurprd07.prod.outlook.com
 (2603:10a6:207:7::30) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|AM0PR07MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: e926f186-fe7a-4151-92a1-08daa89442b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjvqPAi2tQHbfrxU7/dobsUBah6vYJ7AE6VLPWX37kUu7xjGrVluZGahC3SqPXV4Im1qe03Qef5tQCE/FeOFdfHG1n0U/Bv/mSP1Aw2gtmjmDmL/A+oD5a9NfJNn/OWs1mQsxy9stKCabwVe7V/7GVHfkfrDW+1YgxQcBNZvOeLKdEyU32kx11n7DPBn+8EPXHsjqScOXuHY+jq3oTEtigxAp7XpGY+QWjGQDFhMw/x9y6Wf6iBXvVb5UmOy2rwHRlCfWeZv6yXAzoXugg8s6+D7SAiaY2FcoShSw6GWSRVsiqAR+H94LKzrLxVnWiool8VVY2bpcizDLOFjB6fxpz2C2jfy82ygrTDGuj8goihYWHmJYZpU+KUKyjqrLs+xzUiuk1EGbmFWUSUnU+l+IRc9Pdl1BSLeQJ3j8kjkoQKA0rupdaSQdsCE3E4fskNuRFtYKOIYs9qQM4NC5BOwZjAxpS+3knegx9X/0IwOcDA2cGhDoC0d5YjM/zR+SDPVItyWXYuovNAhv/vIJnTYu1XEe3d5ZCkVU1cr/4v2QnfXxj5U2oBYdzw7dccBV/Y4bgZ8pLhX3CBtYPl8uQBFX3XWLI8K1n8U7sEvOBZ3BmT7tkiv9eyDs2kzEGgCna9pu2LRxg7WX0OJ+YC+T53S3434vJQl4mL5Pz1xGY1a8KOJU58Gso12jSgrYxA9r1/JK8mGisupcpCRhBHalX4uruVUcI1MbEGY6iCKxRxVM1aMZyjQfh1bkIocWYzooi1fUCpQLHvvjynkDV6pyP6ysJevEw+h2OKI/NKALTB93OunIyfumBPCtPvCwaC6SP09QkkHeDNDqBS/44ZcafRviS0nnrPFYZeHTMNDkOiFudyPxcTC3vfVHL6t6zxMo6bk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(451199015)(53546011)(66556008)(31686004)(316002)(31696002)(6486002)(966005)(86362001)(478600001)(66476007)(2906002)(2616005)(41300700001)(8676002)(6506007)(6512007)(36756003)(38100700002)(66946007)(186003)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThsR21ISkN3RzFiRHF6VjEydXk4QUE1ZEk5Y1l3eVhtZ3B1MFZKS0NrOGhC?=
 =?utf-8?B?TWQxUFcvZ0JiTUtRT056bFhSaEkzeEZZTkNzWk9UTi9LcnYrbUJFTGpZNWxq?=
 =?utf-8?B?VnNHWkxiRDRmTkdtUnoySTdFdnlqdXUrRUM1WnNzeXNZeWZEdDJNWVNzUWkx?=
 =?utf-8?B?NWMzY2k5RmNZZEowUXVsUE04U2dXVENVekZ0MGpXZzZIQ0J0L3V6R3VqOVVG?=
 =?utf-8?B?c1FNLzN6MkNjNFBZVEFDTHpmd1dJemxOU0liZ2lDdEszZEtuSmVNTHZUemJO?=
 =?utf-8?B?alZlVk01SllKOEh0T0JBZnhPeDBLcld3aFB3WGt0cDd4VUJZY3dYSkREWlMz?=
 =?utf-8?B?VGpTcVRNem1SejNHQWtkSVJOVkZwNThPajNWV0VqOHFxNlRZOFhhbWljNWYx?=
 =?utf-8?B?VU0yTmlsL0RsTHVnZkVmcGtzUVBSMk5FM1E5QVBlTnVzZk1wTUl4YkJ4V0ls?=
 =?utf-8?B?VTV2dmd5bFNsZjljSmljVW9zWWdTVDFzTVo5VmM4SnZpUWpYUnpOcUdsb21q?=
 =?utf-8?B?Q1BYQzJzSCt4T3hGMDZlelVOT2hOWUZ3Z0Zoem1kL1lydFFnbDg0OG9mQ1NG?=
 =?utf-8?B?MWFHNUFtZVJtbG1IbFd2ZHZTTDdVYlNQV21iTy92dnY1SXBZMG5sdGVNQzA2?=
 =?utf-8?B?MERmYjEzZUNqS0dCUGJJZjFWNUxLaWY4Vkd2UVh1OUhBc0M4c25vRGxXRVlh?=
 =?utf-8?B?cHh1d3cyT1owUms5T0VyRFpCMytzekJYVkFsR3VvQXpGUFEvN2NiT3puck5V?=
 =?utf-8?B?NFhqYVVOQUNEcCsrYUsycUE5cTBTZ2k1ZnV1Z3I4MU9sSDc3SHNJaWt0WHJK?=
 =?utf-8?B?TCtDQzQ1QjNHbXVCeFE1V20vcGdXd0g0MkJsbDJoNjlwc1FPcjQ3Sjc2NFZ6?=
 =?utf-8?B?UzZiVm9oYjBXbFFOMms3UGhoM2FpNTl4WkhJME1QZDRSSnI1ZGNOc0pMVkM3?=
 =?utf-8?B?Qy85ZjY2dGFLZThoZ1V1S2J5N002VlVTSC8rdDRkSzNFL1Y5anJUNkxuTEIy?=
 =?utf-8?B?VmxvVnNjQm1McHk2NGRhK3ZWQ2NjaTl1SC8vc0RCWXlhL0ZrYjU5Q3dPMkt6?=
 =?utf-8?B?NEpoRUp0RUgwVndRa1I4Qnd0RCswRld3a1R3Zk4zRVBZMEo0eDk0Y0hSeWl1?=
 =?utf-8?B?NXpsdDVOY05yYjhQWityUzVxV0hoOSs5Z3pqUlBUN01sMHZ5Z25lOXN2V09E?=
 =?utf-8?B?WXhHcmZSS1NtTnEzNHlZeWVBb3hISVViMUoxQUhPZHVHZUVjMkd3K3lwZDA1?=
 =?utf-8?B?cmhISUYwWmlXY0hmYmJlTHU1VTFjdjlLbnk4eE11U2xhOExoZ3poaTFTb1dG?=
 =?utf-8?B?bUh5Q3ZlT2VvdE9Ca21kVTZRZCt1dS96Q3IrODM0NDhJaTYzRWw0eGFMZGNL?=
 =?utf-8?B?SW1EYkd4T1JYeUFEU25pcTBxRDJCSWNJYWJ2MGZ1QXJCYUxCYVNNNnJDa2l3?=
 =?utf-8?B?LzljVW0vT2lmYmltNmJyb1VyR2k3SlNXMDd2cmFBZzk2ZEhsaFhub3duK2gr?=
 =?utf-8?B?c0lGYVRIdFNjcFE4THJITllybE1ncDFUbkR4d0N5NzJOWUttWk92RnloQnQ0?=
 =?utf-8?B?MjNsK2V3QmVSK1RPQWd2UldTK1hWODZFaTAwMEpVbFZMeFlFYUc1RUpZSFhh?=
 =?utf-8?B?alMwaHorSlhrSUtHRVlIV1ZEU1k1STV0Q2hIblR5RG12REErWDJZME9hZkVK?=
 =?utf-8?B?MU1sZzdlNmFUYjVMSlZuTU42NW5mZG4zczFaRFp1cXVuOVVhSVBQWTF3TktT?=
 =?utf-8?B?dTA4TWdsUkNPZk1UY3lvamVpV0tFZDJyRHZMczJidHczK2RSbzhYL3JPczQx?=
 =?utf-8?B?K1A1YnZlWllaT1B0NCtmaUlTVmxOVjBvZVJxbC8rRFFSNmlwMW9mdkVSU1V6?=
 =?utf-8?B?V21VZzhaVi80cnJnSGYrd28wNE82cEUvSS9kdU44SEpYQ2JjMStMTmhYZkNx?=
 =?utf-8?B?SDhtRFloWklPRDFGWmJEeUVXM21kcWFkSVpSZHRYSlk2Q3VhdHMzbnBjRlV0?=
 =?utf-8?B?UXRrZ0ZseVNlc1plQ1BkYlBkdG05NHNvaXByRGhwY2NYTHh4ZWVUVUhWZHFX?=
 =?utf-8?B?S2Y2NEdCc0ticXNkSS9qeDZRajI1S2FObnFmMnVwODRWODJaSHUzZHFpUXJP?=
 =?utf-8?B?MGNuRkpZVG5pM2s3Ti96ZHFjd1B2M2VYNWd4Z1Fhd0pxMGtSTllMck0rVGQ2?=
 =?utf-8?B?YVljYnp2TG1EMmM5clNMWHpnS1hheHdxenp6QjRRby9xZDI3Y09jTUxramw5?=
 =?utf-8?B?UnRzdXFQNm5DaHFkZlM4MFBENkx3PT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e926f186-fe7a-4151-92a1-08daa89442b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 18:46:35.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fOPtUnCRotjCez3dCyqdL01F6p5f0IZdl2aZGjfgCiJ/JNDS5E3gq27xNZjMj6Zh9WWezvoaaVbe4IDDZXQhoLmukS/AVT3VLJLPm2zbkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6370
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 10/6/22 18:24, Marc Kleine-Budde wrote:
> Hello,
>
> this series consists of a few clean up patches by me and Jeroen
> Hofstee patches that adds 2 new features (GS_CAN_FEATURE_GET_STATE,
> GS_CAN_FEATURE_BERR_REPORTING). These patches are based on the
> venus-5.19.4-gsusb branch of his Linux tree.
>
> | https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb
>
> Changes since venus-5.19.4-gsusb:
> - fixed 2nd parameter of usb_control_msg_recv()
> - rebased to current net-next/main
> - renumbered the FEATURE, MODE and BREQ bits, as termination support
>    landed mainline first
> - split GS_CAN_FEATURE_GET_STATE patch into documentation and
>    implementation part
> - added Not-Signed-off-by: tag, as these patches are not Signed-off yet
>
Thanks, I delayed sending them myself, since there were several
patches here floating around for the gs-usb driver, so it would
lead to more conflicts / claims for the same feature bits.

And yes I wrote this, intended for linux, strictly speaking
Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
or
Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>

Regards,
Jeroen

