Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6558F5F85E8
	for <lists+linux-can@lfdr.de>; Sat,  8 Oct 2022 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJHPjz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Oct 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPjx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Oct 2022 11:39:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE4E0AF
        for <linux-can@vger.kernel.org>; Sat,  8 Oct 2022 08:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaHOsUnqjn4r0MvPcYl1BIof5DWUriUPB8EghcOzDC/RSoOwc2EYYCfM/DTY1oqE/OgMwvsQHWH0jSSZCrGrqvW5J0l0BtoB+4z3zeM4+H+1/ZIrkelPidOKqvj2F2Zhr4U7Z/TSVOYikM/efa+VHHe8YaX6NHv8EGuPkNddyqwlYX1DtCJGF/VDwT4GTfz/llcbk1deaYB3eH1jt950FXleWuSIjKVlLzqsquvYwOo+hcUfypQ3JajfKknd+4AH/w/u4icnJftkr1rR/GIohW3/UE7W5gawFLngCx1I4sbZYJoHQzaEYnuqhNfmre7YUfu+tGADm/f3LbM+tYrQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5KoI8n/ALbrdc1wDBI0f4gLRNUOp30w61YQ35b9Qfs=;
 b=bqe1nUvjnq9ghS+g3+I8Il6GBaCQLZ7vVOTSg22y3jqACXqCX4EZg9pRpJ8fCZaTqml+GqvKfMY0XKKa4hr35HKhnHp68oAbHwaNJcQgrR0ZTyf+qtLVK9J1EJVdogc8DEtDyDKkKiQrK0UzQAZ5PhzGIz458d/MQo14ARrnzFp6kj3Lv7QyLInu0rV7xvd7wwAxblf0TFSk2SCoj4MPfywzdmrnYZnMzfpLg6vjA2RRv28L13eudxoXj2/wdVGZ8Q0RHVdeS5H0C8ZlR6lscKTqLNh3RWav3tE7JehkCzmq5cLgK+N1gJb9SszmmlOZ4y3hNpaoxB0+O2iq71JBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5KoI8n/ALbrdc1wDBI0f4gLRNUOp30w61YQ35b9Qfs=;
 b=sq6Nk34zUtZ2q1zZIn1/8oi6i1k2ddNTBd8Ypr6M5JOZ7UIMSmMXcx+FJUlZroKmSjQF2RaECezK9MGrFKECtFChTUk2zGf+tOtRPsmFvFbvwOI+gjf4g4TpKXZ/L21KPZ77DSpJq1h9ZJUYnYB2eXP6SILOwZZHLdRMYneq7tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by VI1PR07MB6333.eurprd07.prod.outlook.com (2603:10a6:800:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.11; Sat, 8 Oct
 2022 15:39:48 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6%5]) with mapi id 15.20.5723.011; Sat, 8 Oct 2022
 15:39:48 +0000
Message-ID: <8415dbdd-8c0b-a427-01aa-c1c5d149767a@victronenergy.com>
Date:   Sat, 8 Oct 2022 17:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
 <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
 <e9a8edc8-c019-6396-6655-fe331c89df7b@victronenergy.com>
Content-Language: en-US
In-Reply-To: <e9a8edc8-c019-6396-6655-fe331c89df7b@victronenergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|VI1PR07MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: b6646668-868d-411d-d194-08daa94354f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWtU35pZU8XEyAf1A+tbLpIg7VvH1+Wmf3BWzHccz7/pd7okwir+6mwLYjsqn2jBz72wKR7L4BAXQr89Fzry4gr+yVmJnF558LTRwyV052iH4JlgoWy9S4Ua1y/gA9VoVNgjdZjQ1CJgyO84TfAjr2PS9SLJ7xdVBktMJNeog0rI/mmSdIlQIpKuKIXUuVtS4Z2MoPQ2qaRNuwlB2QIlVYXCYnE9O4Cfa98XUF2whrktX+wtEICZ3CSRTI/om43CiRKEizDEQ0OkzPP4yT+irUtpZmqvkL5do5nTi893HLwXBCbott2fgEu162PVHYMKSEcRbQTxH5lC2gvU7WMCt9cIF6DLozI/lQbn3Y0aEK4m688XIIlSyfRo9UQ5H6kvZsb58h07vOa7YPXHJCxxPcJHGQxjnliNjduaCvOl8Gor97oEUOWdWxNtQPs43jU7TUKu0X/7LdTN7uBHNadPM50i3bArgtWRVWMfJM3Iyq+37keXbwOtj5hMXJYt+QWIITQRIbNvAmv8g8cQVCHeCOjyhNophpaLvzxtv8ho6spdTbJX/O+VUn+VYuc29khtA9+uWeqopp4tY0YB76ZaTMDkzZ8ljjrX7kl4eWmmOqCcHPonW7VqRKPl+7VAwg9Rkt0FoxqaUbMVPp6vt+bSrhymSrv7FYoJ+EiT/RBYFzGRB972wlVd94Cyn1o7WfV6w9XPmsefIxds/otnHeZ6Hqc21R4KF26PpvJhdYh/JiidUwBWKZkbKoUb0NSVp8Ek/uT/A1nFEWFGF8RYErYK1mGpakZ+hCEXBid/NATB1g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39840400004)(366004)(376002)(396003)(136003)(451199015)(31696002)(6486002)(2616005)(478600001)(86362001)(186003)(26005)(53546011)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(5660300002)(8936002)(41300700001)(36756003)(38100700002)(316002)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEpub0J4YlpReDc1by8xdUVSdTEvdVNkSTZINWRlSDFyeHh6Yld6eHgydTli?=
 =?utf-8?B?ZjMrRGp1dGJ2VlErZjFqYUhHZTJONlhMdHNndzFLMG16b1J3dHc4K3VyWGRh?=
 =?utf-8?B?NFEySWk5VFhBQzRaaEFVTTc1SXlmQUxaTkVYZGozQWdHWTFpMEpEWkxBT1VP?=
 =?utf-8?B?V3hTcEtWZ255UTh2cXR3ay9lajE5Rks4UjE3K3BPOEdQTmFjR1I3KzJpU20v?=
 =?utf-8?B?eEFTYVpCT0xiR0Jib012YUhsUDlMeER0SXFYTFdOS2o5QmgwYXlKelQyQTRC?=
 =?utf-8?B?REhCVG4remRLRzJPWmIzY1Zkb0NzczRzR3dDTUFFZUhIbThJVEZyWXNBbzJR?=
 =?utf-8?B?aGxPb09ua0ZOdGdtOWR0M2d2VXl6Y1oyeXk5Slc5ZEFidzdnU2JrcEFWZ0hr?=
 =?utf-8?B?RHdnTFdCd1hRMGcyU1hkV3NRNlFZNDRXT2IwVFR3T1k3T3U3bTI3bmVHVW5p?=
 =?utf-8?B?R21CRlZQNk5HMGEvME1NT0UwTTNIOUt3S1V1SHJ2ZFRYSkowZmpkUGt6NlR6?=
 =?utf-8?B?NzNQa2ZqMExsVDVob0N6Sk9Zc0kydzZHVFIyL0tGbGRUT0F5VnpQMmc4ZUV3?=
 =?utf-8?B?enBzQXZFSWpuN01keVJ5NTI3VmRzeW93YlZsbzZTREQ5UnFLR08wbk9SR3hW?=
 =?utf-8?B?UnBVV2w2L3E5bEFiT1pTcHQvQ1RPdlpUVllDSnFWOXlhcU9mbFY3V0lzanlS?=
 =?utf-8?B?Wkg0RGcrUlZWenRETG16QWNjemJBam5ZaExZbEhsaW40UjZmS2dmakpZc2ps?=
 =?utf-8?B?UXhFUHZraUx2ZlFrNkg3bHRHYkpEZnhPclZMdkYyNDcrNjFYWGpremZmbm9q?=
 =?utf-8?B?ODdnMEZOMTYwcmgrUHRabDhEM2hRTGNjQVcybHVTWnZEa213MUkrUUd2c1Zz?=
 =?utf-8?B?SG45Nm5jcGRGNVZrTzZSWVFsMm9sWm9pQVkyb3VkcEZsdUkxOFhXOWFlNWRn?=
 =?utf-8?B?VjViNllWdGVjdDRjZDdNVTkrZVVpS2lzYkhDM0U3QmttYmQwOUNnZnptSGdT?=
 =?utf-8?B?dXBvbHAvbEhGNFBxT2Z5YzNIeC9yM3ZxWGpocVYwSWxWT1pNbnFkVVVybHdp?=
 =?utf-8?B?QVluTnNPaGNLVTJjeEdYMjdXY3J3dHdNUlFKVmxjTFV0Zy8rckNsWUtEdVZY?=
 =?utf-8?B?TFh2ZmNKUkRsWmxnTzlSYzZlZTF1aks1TGk1ZGgwYzFQZjk2eEFnajhkTi9l?=
 =?utf-8?B?eU5hUjdOLzErVEVlRGgxNGRtRmdjLzlxOGw2OWtsdUcvUTd4bDhUOGRIYmxQ?=
 =?utf-8?B?UWZrTUtEWVlDZG5CT0kvREs0cHNZNW1IL2tHVUxvOUFWYjhIbUxVTTRMNmxq?=
 =?utf-8?B?cnI5d21TTUl4ZGN3MmZiNDMzNElZODBzNThXdFh0VEo3Q05WNWlPOXRsV3cr?=
 =?utf-8?B?blZ1WVBuOE5qQTdPZVZDQXR2UXpXUkQ2QlRZY1VReWIzb25iNDV4d3BIOXgy?=
 =?utf-8?B?cnZpb3NCd1FXbVg2b0p4czhabU55dFFNSEZxeG5iV1pOOVFPUzNiZkU4cFlF?=
 =?utf-8?B?WDRVY016QXExbG5yTWo3WC8ydWRPTmo2ODhHd3VmY0pXbURVNFg3T2RndWp1?=
 =?utf-8?B?N0NzbE1BSytDRVVvUVAzZlpiVEVhVGNKaXcwb2M4QVhjWUc2MkkvS0dSNXJG?=
 =?utf-8?B?dkcxQ1p3alpuZ0xxa1FtR2VmemlBUEJBbWozbk5Lc1NxdXkxY3A1QnE2QTdo?=
 =?utf-8?B?TDVXWmlKampTdFhBTW1oNTZSMXVhZVk4LzZhTFM5dlZlR2pWdzgxWmFlcHFw?=
 =?utf-8?B?c0VFbFhDalgyM3dIVlJlUHJJQ3RaWkZqOHlZa2lsWXJzdXpjanh3MFZhK1JO?=
 =?utf-8?B?bzJsdHVDZ051WHVaamMrYS9sallTbGhXU0Z0bjdoK25rbDQwYjd4eG5sREp4?=
 =?utf-8?B?NlFKYnFGNmdqQkh5SmdQdVFVYTlGVXltL1RaYmVhWmdpS2ZXMStxMDI4eXVD?=
 =?utf-8?B?VTVUYmlmeWtWYVUzZXNiRktQMExzSTFpa1Fsb2E1c1NJc1FvcDFpL3Ivd21s?=
 =?utf-8?B?THA3aDJkb3ZCMnZLUFNpNVBoUTN0WTJ2aHd0NXZybjU2T0E4MnBaMzR6VzZC?=
 =?utf-8?B?ZUdmaTFlWUU0WVU0YTBOT2pDNy9JQnBDTVRjcVBnek1SYmZjSVpONS81OWpx?=
 =?utf-8?B?T2hZamlHZVRWYzVPZnFuUWE5TENaSk55ZEp4ZE04VUIwUWFnUXNIYjY1T1dT?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6646668-868d-411d-d194-08daa94354f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 15:39:48.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9KVDwQydmw17cOYOOUgJG8iCetnnTmu0Hg50uK3B1at/A0RpoGyZomfR9CUrZu/1QCAuoJJ0dzWQ5uNhz2oIzXmp3AOrzlvzj0ZSBGZd40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6333
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 10/7/22 20:30, Jeroen Hofstee wrote:
> Hello Marc,
>
> Thanks for looking into this.
>
> On 10/6/22 18:36, Marc Kleine-Budde wrote:
>> On 06.10.2022 18:24:50, Marc Kleine-Budde wrote:
>>> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>>>
>>> The open source firmware candleLight report bus errors
>>> unconditionally. This adds support to enable / disable bus error
>>> reporting with the standard netlink property.
>> I haven't checked the candleLight firmware, yet.
>>
>> If the unmodified firmware sends bus errors per default and we introduce
>> BERR_REPORTING as suggested in this patch, we have to modify the default
>> behavior for bus errors: By default the firmware will not send bus
>> errors, but only if GS_CAN_MODE_BERR_REPORTING is requested during
>> open().
>>
>> I'm not sure if we want to change the default behavior of the
>> firmware....To work around this backwards compatibility issue we can
>> explicitly turn BERR reporting on or off during open via
>> GS_CAN_MODE_BERR_REPORTING_ON or GS_CAN_MODE_BERR_REPORTING_OFF.
>>
>> What do you think?
>>
> Personally, I wouldn't care about backward compatibility, it was added
> later on despite they know it should be a socketcan option, see [1] and
> for most if not all users, having error frames on a bit level / crc 
> mismatch
> level is only annoying, unless you are really looking deep into problems
> and then enabling a simple flag isn't your biggest problem, especially 
> not
> if it is a documented/common flag which is supposed to do exactly that.
>
> Obviously state changes are still send after my changes to candleLight
> are accepted without bit error reporting being set.
>
> So yes afaiac berr-reporting is simply turned off by default. Unless 
> there
> really are users which need them and can't simply set a single bit; my
> guess there isn't any of them.
>
>
mmm, that is with the patch included. For distro's that will take quite some
time. I will have a look if a backwards compatible version can be created
which doesn't look too odd.

Regards,

Jeroen


