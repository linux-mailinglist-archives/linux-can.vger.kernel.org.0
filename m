Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5B5F7D66
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJGSag (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJGSad (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 14:30:33 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10092.outbound.protection.outlook.com [40.107.1.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB5A3F7E
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 11:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2gg5PKoroehaYXcgyESa4oSI2+gAFd9jK/jjGrZg7KWehOkFRtTKkc4zZeQqKY4/7USmumcRAMDNVcHXY2vfnUQK67TcwUwNgF+6VzrIukfJkTyQ5ZUucLsSbc4jyCYTiiioUt2QSP3lheo7+J6G4ViQEEjc2fU4EhAXY3vHhuHXyNjN2vlYvSOXgEecHJgrL4ry5+aWOylayAs2dUhKFViryfZiB/i/okaGESxTgsk/zvk77DpeFrxsmDTb2qtaeDg07YRv1W5AqC4cU4nXIUvUzFBIGKxBM2URTZ5sC9ZrNcxp9MeRlcf8S2QOYzHiAqVLzfWJ167DPeeFm4S+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wquF9wdOWp7YMK9JQUQ6zvMCV7t4oosTa8xiVlFe4y0=;
 b=bkkHg9eAjgSo4KQXJKkn6anzi9r87Czbnfd9virfGWYww9kTKtutsxNkdqs2xYKJR1vvqBUqgBXJFXYuzCRraAhst9Py+X9iK4fvRMN8ZUd7EQkDkvws6HN59eBqrEYjwXdhMZ39SyeBeBS/jZTSKrPf370G7PAkIpyp1Jfm4k6N9GbVL8vmj2HBuuvE8VC5eP1OqFnXFZ+8uL3pOdvKfiJRCyNVq2wKpeUoBU9ezyaJ4j1mnE3m+eSRxdrfz03XNQSGDp6F9Zfc8IXA5CLZwmrpqQsofOd9zkIOGurlbKyuMEWl6zmdhom73t64A1B45vplp/iArfnV1IXfzBGDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wquF9wdOWp7YMK9JQUQ6zvMCV7t4oosTa8xiVlFe4y0=;
 b=bEqQfuPdLKNPRcF1WSiLHumNyz27BhAnyUegIxysnVhGBsjPIFGg1V7CxEE6PYYDHppyajloKcRtohcnXIW206+GQujwepP4kjtUtW5jbjFmPHvZsJdlJKNLg9NHCLppMKvhSlGdtSU1A9Jr0je/b8H3sFFB5VnnJadjcML1c/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by AM9PR07MB7940.eurprd07.prod.outlook.com (2603:10a6:20b:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Fri, 7 Oct
 2022 18:30:29 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6%5]) with mapi id 15.20.5723.011; Fri, 7 Oct 2022
 18:30:29 +0000
Message-ID: <e9a8edc8-c019-6396-6655-fe331c89df7b@victronenergy.com>
Date:   Fri, 7 Oct 2022 20:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
 <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0024.eurprd07.prod.outlook.com
 (2603:10a6:200:42::34) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|AM9PR07MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d48eac4-e39c-47f5-a8e2-08daa89202bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czUIPJ+TTjZPkPbU3v1IVh1E1QzofgRzjtpFL8F9HdF14qjUnQY7poglgG+lsy3DhUl/Xy7OvL5qpnWRpC8TrVzX7FuCSj4DT7PkU7yyGfxGCebfP+MhYEu5thnhtJFJfs7/x5Pc6X4j9+7yaIkeJvkTJlfT/J8zpWJN3fTSCy264rFPnqtvYJfHGf7dWUiA0Hiz/19ScjL4FwX9VnN7b4Y8yTBKhgr2qA5ogYFrThi4pygA3yG4LpSIVyUxFLMyAJ8P/FlCe6odHWEjdRYPeN1LIe5xPr7MiN3Bmt38Y7sZPyRNhfPaoYyGaN1gkaB9YV9vruEoFHOUIRkbNO9sh7gWUK3amFLaQKgawXfajy8HFDYQGbJo6x0TZgBK+4EpL3s+J0JLJGacQMDMs8PeIdNwmadwCoEBDwNUhMnAxvv608CY92K7bL4QO+MsZcI7g1ZTWWGvH0LE+ksoAiMlYHRerkOymd2AxwaBiHOe9dWOOiMGeH/pYiSm8+XL4BobgjjWXMMnhPC/izsGR3kn3wdnLqHWBoi4N0zBZWge335yRU8HLFOarxFJXygGCXIoPRRzZOKxw+DIkQPdFLE+sz7F5KuvkuiNopBc6PJ5tJ9RbSR1BJVg8rDzZLIj8hJaEnjzS7CnoWCt51Vj9MdyYwG8POFhxiWhCxunXVnj84Fw5Hw+fvNFfpnCpBjCwFRCVZFlHa/lkNtESJZq+18TbZ4tDbENbvAOLIu6qEgfTUiyihYneWtT1oKFCVFO/7DsjYAmxhngMsUq3L5fkVZxTrhNgPRpFZQYv7aLWCcVJZXBvZXwDaV19X8kI4oGg/xQc89Vng6LbStdkVmX+eMijveT85nt84ebhjoLSAO4ouP9uVSgGeWS7lwsAfVfSS8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(451199015)(966005)(6486002)(2906002)(41300700001)(86362001)(478600001)(31696002)(5660300002)(36756003)(8676002)(66476007)(38100700002)(316002)(66946007)(8936002)(66556008)(2616005)(186003)(31686004)(6506007)(83380400001)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJHejczQnFtcUJjQ1BDNUQxNFRPN3V6cHUvN1VWTXdyaDdma3AwL0tmSTRn?=
 =?utf-8?B?bjYxb0ViSEdhU0JPWmZUNHlsbm9CVFhEVjkwQkFjVmQweklLK2NpUEhTNDhL?=
 =?utf-8?B?RWdJemcrQytpQjdyMWUyMGw3eUs0Y2xDejJjNFI4cHI4Tm5NODNhKytTN3RJ?=
 =?utf-8?B?VE02QW5rcTJTQ3FvQlhiSEtmeHRXbjRHaFNUcVZzbkx6WGVrdHRuSE5ZQmMy?=
 =?utf-8?B?M1djM2Q3Z3ZZc1o1VTdyeTkzYWdXa24xajJURld5SHRBTUhTTGpDSHBaWGkw?=
 =?utf-8?B?S1pmeGtpSlNEVzQyamp0MmdjUk1kUnEvUDkwUEhDbjJSeUdwWExlWFNhTzI0?=
 =?utf-8?B?S0lpSm5haFh1R2wzK1BCSXBsTndFbEhFam5xb2o0ZDA2MEsrVDZPb2FRNjBX?=
 =?utf-8?B?QlhJTG5hVmUxRmZkcHFleXNrWTVSWEFlbEtURnNwS0FrTW56UWZ6TVh4UGdS?=
 =?utf-8?B?TE1icjAwUHlrWDZrRG40MjVaQjFYYmVCalJiVkVRNlB0bjJRNHMxVkZVN3h5?=
 =?utf-8?B?QVdhYkJIc084ZXRpZjlOL1MyNW5ydEpIcHZvU0dsVmUyWGFNTzJtaFZIMXU3?=
 =?utf-8?B?TzhLR2paNUZxYmZYZDNFeXN6dldmYjBXNjRLUFBRWm9pbXN1R0ZmUzdhUUZJ?=
 =?utf-8?B?S0ZFQ1ZBUm94RlV3MmJocVBYckIzbXcvNmpNMFA1T3NHUlV3T05lV1Yxa1pX?=
 =?utf-8?B?a2l6dE84SUxwOThFYng3Vlk4dkVPZmg2YVBzSTdUditiRlc0RWcrdFFRSGpO?=
 =?utf-8?B?Wk1iV1dTdm0vUGYwVnE3T3BZT0syQjZ3SkxXK2hNcktZejBkWHNnVmRnNFJU?=
 =?utf-8?B?MlJ4SCthNUVlZWxYUldrT1hnZllRL0xlR2ozYXB3UU9CNE5jdmR0cDBBWVNn?=
 =?utf-8?B?OHduL3J1Q1I2WUVvdVdTUFlwV2RPOC9udW1ON3JJUTNnNlZJYVFnMmZKT1RZ?=
 =?utf-8?B?cDRHSlIzVUZmRm00UEhiZlUvRVRNK1YyNEFNTWFlSlovY0J0c1RBTnhaUWNN?=
 =?utf-8?B?YnN3VnErSHJ6VFJaZjF3a3dOc1VjQzZVQUpKZ1pQZTJRUzZWZHNYKzBCaXc3?=
 =?utf-8?B?OGZZVFltY2l6QmdoL2EyY3dsb1BRdFdhWnpqRUNDVGVvUm1iSVE2YndCRmtD?=
 =?utf-8?B?THR5ZWtkWlFuVWNkVzUzRFZRTHd4VmNCYmhjN2diZU0vdFU5SC85QVpCK3E0?=
 =?utf-8?B?emtkMkZ5dEZqZy91RERDa0oyWjhydk5UejFHMEp6SDMvTURZY2tWNnFpWW1F?=
 =?utf-8?B?NmlMN3gxUjVTTktya2k1aUhHZnpySzY1WExQdmtpUHlGc2FlVG5tWjJYOTky?=
 =?utf-8?B?Q1lpU0h3SDR1eXhQNWZjUHU2OWtWSFlITHVpRkQzTmw3MHhNT3NaclZ1NTc2?=
 =?utf-8?B?a0tRZ0N6Vy9Nd0VvbWFEamdENjNjVVM0TDltdHA3STVKN05RRDMyYjFUdkFy?=
 =?utf-8?B?QUczcmdyalJMa25UdnVUYzVTSzVVUTB5aFM0TkpUNi9JdkR4UWpjSVlVc25V?=
 =?utf-8?B?TmhLU1FEQWJqZUVkY1J6L2lJNVRxYURYYmxqZFRHcEo3MFlRWWZMeEF6cnhv?=
 =?utf-8?B?VWpWcWFoWWJscTZoQXNUM09qZHlhTWY0YkdkVklSakFmMmg2L2FCcHcweGNM?=
 =?utf-8?B?bzhFcTdqUmVkbmo1ZTEwd3NiVXpuNExla0phYVMvT0lyYzRJaXFWRmdKNUVy?=
 =?utf-8?B?L3p3eElSWVltOUFkcUNVeE4rR2dEU3JjWGxJWkdqTGNrU20yZ0g2T1hTa1NS?=
 =?utf-8?B?L25ISGdKcmVtZDRTcVVFLzd1bVJOQnd0TlhDYm9XdSt1Yzk3TkM4d0VRMDhB?=
 =?utf-8?B?aUtaSm1CWXQrQjJ3aTJHU1RjN0RRRHBndlVRY3N4bi9BdDFJeU43ck5EdDJQ?=
 =?utf-8?B?bHBUSU9RQ3JIL0pDakF0UzFxbkpQeDdqWk4rczFBTmNZUmpiODlPbXBycDBw?=
 =?utf-8?B?eHpsbWtJRjdMVldZbktRMmdPSnNCc2hOWXFJUGx5ZDVKR2dzV0t1TEhOWlgw?=
 =?utf-8?B?TWUxcTlVOHJqYWpJWjZEc3Mray9ucEpaSENLMGY5NFhqb3gybmNFdUtUdkxr?=
 =?utf-8?B?UkwrN3pReHBaSGpxTm9nUmFaT09xS0hsNGRRMUNSQ0JaRENqaS9PWVFJNGJl?=
 =?utf-8?B?SlcrR2tOc3h2RTNwUTZRUG5LM2dFMFFkb3V4TFQ1WTJpa2JHQjJYRG5kVm44?=
 =?utf-8?B?bUdQN1FRUXJaK1MvS3VCNE4wSVBLZm1JUVdLdVNHN3U2dDhWQTJVK0NXRm13?=
 =?utf-8?B?N1FKMlNQOFJPMGpLU3ZZd1FyOWpnPT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d48eac4-e39c-47f5-a8e2-08daa89202bd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 18:30:29.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3e/hqjF/o9LhztxeFHq1wzPrp2JiRnvRCgL0mLBvWg80jXagGASFGO8ujplXEtWuRy7erXhBFCgT3kAJbDUtLCFnKs/KwOaCiPsxKEtbnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7940
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

Thanks for looking into this.

On 10/6/22 18:36, Marc Kleine-Budde wrote:
> On 06.10.2022 18:24:50, Marc Kleine-Budde wrote:
>> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>>
>> The open source firmware candleLight report bus errors
>> unconditionally. This adds support to enable / disable bus error
>> reporting with the standard netlink property.
> I haven't checked the candleLight firmware, yet.
>
> If the unmodified firmware sends bus errors per default and we introduce
> BERR_REPORTING as suggested in this patch, we have to modify the default
> behavior for bus errors: By default the firmware will not send bus
> errors, but only if GS_CAN_MODE_BERR_REPORTING is requested during
> open().
>
> I'm not sure if we want to change the default behavior of the
> firmware....To work around this backwards compatibility issue we can
> explicitly turn BERR reporting on or off during open via
> GS_CAN_MODE_BERR_REPORTING_ON or GS_CAN_MODE_BERR_REPORTING_OFF.
>
> What do you think?
>
Personally, I wouldn't care about backward compatibility, it was added
later on despite they know it should be a socketcan option, see [1] and
for most if not all users, having error frames on a bit level / crc mismatch
level is only annoying, unless you are really looking deep into problems
and then enabling a simple flag isn't your biggest problem, especially not
if it is a documented/common flag which is supposed to do exactly that.

Obviously state changes are still send after my changes to candleLight
are accepted without bit error reporting being set.

So yes afaiac berr-reporting is simply turned off by default. Unless there
really are users which need them and can't simply set a single bit; my
guess there isn't any of them.

With kind regards,

Jeroen

[1] https://github.com/candle-usb/candleLight_fw/issues/59


