Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39405F7D92
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 20:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJGS7u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJGS7r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 14:59:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2107.outbound.protection.outlook.com [40.107.22.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408717AB7
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 11:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcIMbJVUfvRkrI6/8cTxJbWAr0PukA8I5TzaZC3rDBsybcF08DQFCcend3a9LYNeANZq76eTaCYF+oQTqKT3KPiGJu+4TNtR2tpCGFZ29UaamLM7MCxpwCvp4Dip63RhvL8lLWDdTriRa8JPOPVXGKI0vTRSj/HZWI7fbxHG9D38aNP5Dj3DVgcawvpYjtzqcS8GKnO0QlDLcr9whA9DgUvpWHGmMFqNbcOJBVH8epUSYZUqaSIW5O1vZwjhs74ty+kx1LPApOqZH7nHU1Jbu872zZBCWiqfESafebrT9ADXgPi4W7lbqtfMbXldyzjx39RTyzOEVPZVwkRmgfWiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akLGuSeeoA09rbUvaCnVL/BdKFdCRPq3zivKul5rpBA=;
 b=albYMe0ZYWXt9UkXBO80J5QuAo2Jl47tdlrONwxx1KJUkacY4lkDiJYkOoUY4VnX1zuzU5fkixqNZNR3RF97INRr/NJDSgrDLds8/fkf1yrLPoOO/FHNhRDmsM6NeJQg68l5EYXUbHIp9hiCBOkdLENIyTWCM0VgSnb4wTDXVNpR+gBqjFgr/0g/VQBi00P3LStIrGj2tPhdaE2tx5kfzXhP0z6bqacXpwLnf1WvHVKRM1jTPl61fVASqtAXh45bK3DQ0Uut1fy3yab+w9RDN0ZA+rSNjIHLKrlcnRXAuGzwONpYgWdYyTywuFELfT3+tp9bTdSXLopCMP1WHnREoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akLGuSeeoA09rbUvaCnVL/BdKFdCRPq3zivKul5rpBA=;
 b=zYMpjwNR+ICMfLvDFxFjJ9HE9bq+xLx5ZiZrw6r9AsejNoxS8mTMqHqyMFC9a5O1hNmedrenlCjc2l+0/yZ6TLNwgFN9rwXwLNe+5tTB6k6kvMXN/5vvtkTe5HQrq3jk0Sfjm9PrqQFj8CmecFwFLiKA+BgtMvjeQTFulXzpgQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by AM7PR07MB6915.eurprd07.prod.outlook.com (2603:10a6:20b:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.11; Fri, 7 Oct
 2022 18:59:44 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6%5]) with mapi id 15.20.5723.011; Fri, 7 Oct 2022
 18:59:44 +0000
Message-ID: <5bd818e1-3573-080a-d15a-b94594c183e1@victronenergy.com>
Date:   Fri, 7 Oct 2022 20:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/6] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE,
 GS_CAN_FEATURE_BERR_REPORTING
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162823.2rj7e63xg3li7fi6@pengutronix.de>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20221006162823.2rj7e63xg3li7fi6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0015.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::25) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|AM7PR07MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 801b82f2-45ab-4687-ff6b-08daa89618df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9xLd157RU52Rdc9WcsyLY9uMKIz3Zcv1nX0zvs0vo1CDxcHeWsUakw09RHLXJkDhgjZgRaa/hF0gHKCReBBybatsGqOREBSJTmP9/ZMIqEMp9etLMqCXrOWkngP58wy78AoQLNOC0/Eu3pxBl1TFplLJ3Wt2RBocsDubBmt+yAXWKZjHD/L539RhnR4JoKO5sTi6L8RqiuG8FNK80+Vz4LCGUVnFbNGGecn01EEyAUtpRJqSA+fxAIoQGgb7HIir0HFtV+asDlKdcKE1YAgDkRK+CDgt3XsfTd0DJ6WtCxCpza9coOd+NKVqcAH5J/Jfa2K1RHapWEO82gBDCFDBUDBGiMqWC+UvlIATT+EoSfWOsFUZTza34v7znUxBI9lrK8wYWXUBWc1CSIWvjsXYsTsqZfn+KbqA8v38UY0eXjwMTqkMGU57WVbCWJZqT+ELWnsSeXjj9xEXOqHC9ZBrPsKsLnAEiRGMbBV1c+/Tq3xi8Q3Kepw8oqlFBZzrCcRfw3nEKXB1H/skY7pluOLfg6dm94ZbUEovg+WmcyRjQ2jV1Ol84IL+PRylgVLKCPnINRiWTstEV6mkEVQd8BvfIhZ9gfdTC4g+U9v3LEWHCiFMY5eCXUyVkaLgCRM1tXK+GcQJIoVzNlUMoRBiizbF2uR+IklpM8PAr+9W6qcM7vE35l0jGODTFGqFXHiwQXv6hPG40Uk6oMYUAx5NuE9GtTM0w4FpffTkCjTrreN9jh57yeTXSl5GLIcgyH+PN6akJTB7PWiyunM9LP2zEP71Mdi190ZxGa/mXMlUn83kHxohFA6ZvzKt6BK4Snhr0foG/Rc0HjDnnJV6y415ZH9aex6XmUsTrAzJT1jH2s2WVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39850400004)(451199015)(478600001)(86362001)(31696002)(316002)(8676002)(66476007)(66556008)(38100700002)(66946007)(41300700001)(2906002)(186003)(8936002)(5660300002)(2616005)(966005)(6486002)(6512007)(6506007)(53546011)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWE5RVoyUjVaYThxSlVtNkxnYmFkLzVxaWVaTEVMUXRDeURoQUNlQnZWelQ2?=
 =?utf-8?B?b3ZZV1lNcmU0ei9xbHFNeFFpSXJTdGM0dTIyblNRNllqblF0bDFSYzF6T05s?=
 =?utf-8?B?bTFCcUh2NkpTeDVMdkFyQlZuOVY3NUEwZy8rRHZpekRoQlUyQnl3QWhRbDZR?=
 =?utf-8?B?a0ZhRENPMUFlSTFhMGNCUUV5YnFEVEJsQ0p6OC9vOWROcmNOaThNcGJrVnJX?=
 =?utf-8?B?NFVCdDZpTGZwSUhrcEdnSE5qaGNQZDk0M3hyVTNjcGNBc2lEbkFaV0I2WWF4?=
 =?utf-8?B?THJCVGdmaGRkN0pCTHY1NW0yN3lGMEpXc0hHRjg5WEJFWjQ2Z21Gc2gxR2RD?=
 =?utf-8?B?SksvVTF0dTBCSjBvaTVUT2RjWFZ5cUUrZzJHemx4RXp6M3dxYXA3NDNRYmlV?=
 =?utf-8?B?ZXp5MXdSRy94b2J2MmdEZzYwRVpvajNpNC90SUF1MjZKWmw5aGEyYTRRWWxj?=
 =?utf-8?B?VCt6Q0pkT3NtK3czY2hMTTNIaEt0OVRMMjkwSXR4VjhtNTBpSDIrNGdwVUJr?=
 =?utf-8?B?UTlmdi9QSUx4emplaDg3TEQvUVhZalp5T2lrQzJ1L21tZUVyZWtQQ2RsTnpH?=
 =?utf-8?B?QkduVko3THJXUWFyVnVVK3lOSkJOZjVZYTl6cmpEYjNrcmhDc3UxQjRJN3J1?=
 =?utf-8?B?UGdxYytXNkhpQm1qd0ZrODVYYy9hQ1Q2T0haZm5ncC93Q2x1aWlyazZCM0p6?=
 =?utf-8?B?bmpkWlRndjltRmVKWC9rTWtyUlB0TW5JZmxUN0VydmhmZUk5K3dkN0h1elBE?=
 =?utf-8?B?aEt4eVIxaUJMSXQ5aHJLWE9MRk9TMFlNblRXc1o4bW1CZzVsd25ra3M4OU9j?=
 =?utf-8?B?ZklqOXBLWHRoZzZ3SzhLUFVhUTJUNjNvb1RHR0EycXVrR0N4eXFISHRlNTZC?=
 =?utf-8?B?dzRnQVp0ZU1DbG1DcEMrUVRmVURoZ2ZDbnJQM3liZVN3bE83bVVBemVBQU04?=
 =?utf-8?B?bUhLVlVVMTBLY09HZ0hCUU1xRkFIc011NTcwcXRSNEt5bmc2ZFZ1Tk1wdXBJ?=
 =?utf-8?B?aEZONzJJRlVidTNLbWxtdkxpS092eUFCSi9SS0sxdTd5S2tHdE5wQXRHYW9t?=
 =?utf-8?B?M1poQ0dBelA2K0pLZGgzUC91MURWYkhVdThPRGk1ajVla2hRRW5GS0diaDgy?=
 =?utf-8?B?TDY0OU4wRlBXbDhsRFpmK2NCbFZZaFVtTnlDSVRIaUtPM1FnSGpWVnYrdUVE?=
 =?utf-8?B?U2Ixd1I2QUlHaElTYVJWMGFWZTlQWmNOSjhqK1hUQmtwd2ZwM3lQSVNKYUlE?=
 =?utf-8?B?LzRxRUltMWpxVHZlTUZUUzIrTFRZeHNYVkZvQ1R4U0RRa05LZTIrWXFiK1k3?=
 =?utf-8?B?S3lpNGZUZVNJRzY3Sy9QN0hWWnZMNXBjZnRzeTBITWRpSmlNS1I3d0JyejRi?=
 =?utf-8?B?cUcxQUR5cWI4YmkxRFNIcHQ4UWpHSG9CWm5jdTNwS3czWWxPZVZjZlVERUNk?=
 =?utf-8?B?aWRSdHk5L0ZXKzRUaWxGazMxU1ZHYS8zeEZSM0tJUGZsVURzWFRCaUhReE80?=
 =?utf-8?B?dnp5ZU1zUWF3TzJMbFcxUVp2WmxqK1c2bGxJdGI5bWZ1cW83L0xCaVVPUDhN?=
 =?utf-8?B?VFhOLzVYdG9kZGNMQ0FJSGtZSkFKOVAyRzBnSjM0MWpQRjJ4NTIvRVJhWWVG?=
 =?utf-8?B?NWhOUUNkRk81TVJ3T1Y0QmFlRDJnVGt3YzdTaWl2bU1QVEdUS2VDd3MxTHF2?=
 =?utf-8?B?TzdnZHZ6b21sWkd6VUQ0eGtwNTcyQ29CTTB6cldUMDBNakpGTG4rVVN6V1Zl?=
 =?utf-8?B?NHpHeEtjMjRTWVJVclZYNFZwbEtpSk0rV3IwRG8rNUZ5MHVkVmk0MkZxVzFj?=
 =?utf-8?B?N2o2SUlRc0JIem9tT0pLNE5TdzhCMkU0VS9sV1hZNlVnREg3QWlZUnFOSFAr?=
 =?utf-8?B?Q3plWFEvN0NjMTlqOXdVWVdPMEZMSmZVbytsMDVvK1BVMnZ6Q0xUMlN3Ullp?=
 =?utf-8?B?ZHd0VjN3dEhzcVhJZ1BnL21vUE1jNjJzYUlUcGdTMlFXYkdtNUZEbGdQaVkw?=
 =?utf-8?B?ZUZFUDdqbUtxbFExQUNVRGd3bytaRTBjUDh0SWI2dTBBWEJKTksyWW1hQjJT?=
 =?utf-8?B?OGlQS2JsNkM0bDUwL3lXaEk3clFhUjRuUDdUeXJKRFRvMzBZVE5NYUJXMnIw?=
 =?utf-8?B?aytQTHJ3d2lwR0lISmhod0JwYkFLVm05c1QrVE5QSEZ2VndqNThiK3J2VUFv?=
 =?utf-8?B?RC8yYmllOSt1anQyUmVBT0dWdW41MHhBUHBBWkFGQ1Q3c1l1S05PelE2dTJL?=
 =?utf-8?B?VDZuSXBZSnoxdVMweHpzU3Z3STlnPT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801b82f2-45ab-4687-ff6b-08daa89618df
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 18:59:44.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvEmkyWSeKqD+OEodoyjZBglBhUoIVljn5vRxSF1Lr1XQM+OHyHwFiRL6t5NTJK/5uXoyufpv0lHb/n0/msdgSo4qPbMXXl4fwWm67SC3iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6915
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sorry for the spam, I already replied to the cover-letter,

On 10/6/22 18:28, Marc Kleine-Budde wrote:
> On 06.10.2022 18:24:46, Marc Kleine-Budde wrote:
>> Hello,
>>
>> this series consists of a few clean up patches by me and Jeroen
>> Hofstee patches that adds 2 new features (GS_CAN_FEATURE_GET_STATE,
>> GS_CAN_FEATURE_BERR_REPORTING). These patches are based on the
>> venus-5.19.4-gsusb branch of his Linux tree.
>>
>> | https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb
>>
>> Changes since venus-5.19.4-gsusb:
>> - fixed 2nd parameter of usb_control_msg_recv()
> See:
> https://github.com/jhofstee/linux/commit/6757d45f74b7e408cf3054cd4acf66883051c03d
>
>> - rebased to current net-next/main
>> - renumbered the FEATURE, MODE and BREQ bits, as termination support
>>    landed mainline first
>> - split GS_CAN_FEATURE_GET_STATE patch into documentation and
>>    implementation part
>> - added Not-Signed-off-by: tag, as these patches are not Signed-off yet
> Jeroen, can I add your Signed-off-by for the patches?
>
> regards,
> Marc
>
Yes I wrote this, intended for linux, strictly speaking
Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
or
Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>

Regards,

Jeroen

