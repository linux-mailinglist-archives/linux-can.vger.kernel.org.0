Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61516455BA9
	for <lists+linux-can@lfdr.de>; Thu, 18 Nov 2021 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbhKRMrK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Nov 2021 07:47:10 -0500
Received: from mail-eopbgr50100.outbound.protection.outlook.com ([40.107.5.100]:31716
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243861AbhKRMrI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Nov 2021 07:47:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkXI1fU+UtuN6u4pfE9VtVXA661HDjzYkns8Kxy/1Mz9t0qcFn2PWK2VfTl/lV0HEwIkSjhKcwoOJW9T+kSAbvMt2mT2qYALibSp9YoNwlYhgcOEyQVu3HopOV2cciP1zgGYCkq87hVY9D4+ie6E1z75X0nmPIq78VjAF3TNtg6IlGKXKnG6Qik0ePAVTojqOjtcLBh7/NbHDbOxWXo7jy/gCBuQsaYOuQVG3Nb314/j5j/RZPCNtOH4jjuTtkzDxmuTZm0nvZKwQb0rhQxonTBAaJuF4Y9PoQ/J7vbE0SfqNgyHspr4/YpPI0tOpYkQ7V/EAydECJ43N0rY9OiV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk4fMCdQhfC0Z53R7mCSb8NyexlyUcCmYvAIx70XCjA=;
 b=dWW4z8WsZohCFw18rmkHl2Riq0Ge1hAVNlh1PrriANGk2i1WJHhP0vClnXb/VuUU58xrA0mRrE/zeKlyOBDD1A0jGa/ELVum5CgG0TCV8XN0grIwwxv6zRSTVHgqAT1uSo2X4J1B6K1G7rl7UK6hFrp/RXjpnWcw3IdvdTIPMJRzX+7075lqfGBJuoecKC+TNyn0rT2DCAulARLj7QFuky0Xi8pIT3qBObpM2OfWcBL30G+l50j/ThlBXrTxlFyNkX92Yx3J9r2ai3vv5pAPE2cVHGTJx3j7tJl6XGnsMpbpRBaotTTBXRyTITLk8ttKapJgGmV5qloISscEPrG6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk4fMCdQhfC0Z53R7mCSb8NyexlyUcCmYvAIx70XCjA=;
 b=d4IVWFHDs32vlwbLQ/yuT8ZWoKQLkhCPC/m/XIyGjR1JthFlWizeMgYSvJkHO1dEZdknypQU/+0vMmiHcyMFI1AEkhCc5nAg5i/2UPO+3byqLXfq1YvOp2Y38gohvLYpE1PS3pt7iPShlT11W0p274Fr1Aq/cuGGrb8TfMWm6Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5241.eurprd02.prod.outlook.com (2603:10a6:10:74::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 12:44:05 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683%6]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 12:44:05 +0000
Message-ID: <3f13a769-f8ef-dbe8-f2c6-ff197af8eddf@axentia.se>
Date:   Thu, 18 Nov 2021 13:44:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting
 mux
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211111164313.649-1-a-govindraju@ti.com>
 <20211111164313.649-3-a-govindraju@ti.com>
 <20211112084027.b2t2beqiiodnwjtv@pengutronix.de>
 <085ec3c0-75c6-f3c2-9999-348098fd88f9@ti.com>
 <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
 <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
 <b8b0c7c4-3006-071b-d68f-8b18d24a1f72@axentia.se>
 <f47dc612-adea-4dfb-f2fd-d67b5df6ed50@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <f47dc612-adea-4dfb-f2fd-d67b5df6ed50@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::10) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 12:44:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3a9f8e-0ef5-4ef7-51f7-08d9aa911b55
X-MS-TrafficTypeDiagnostic: DB7PR02MB5241:
X-Microsoft-Antispam-PRVS: <DB7PR02MB52414DF2738D2B14E1ACE707BC9B9@DB7PR02MB5241.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOHwJ+XUMtGcUGrKStanBbLoZqj5LidLZySl7JyOW3dg6P2vWIci+OLOpuPYP5dOKAH/85CH9MIZp8mmWeFPfnBtzieoNCVYBK+9925zFJcJ6mNCOk8tOvzOnWVstV5rcFBZifZye1cOFgvrKIoQDjxbFgWx42ToI+tLcgRBqydqcCxD73B5C924ikJyggSAvmDKrEBn2xdugFOVHi/4YSohuiAa2DlDurPURcFOHN3aRFotUUQ2/dAcwFmGUTTYukpb3p2GAMx+1WUwveQEK5SxQ8UxH0g3RgV8wm90103EJvZpcktoN0PH053/9oPEsdb1cmiW6FNv8B3oSh8Ciwr46hI55hRGAcPzjOpgG/auF1FxrtoORWn7+QDSdYrCHb2MxQW8am3SDQu1XLKRVfmSPCUatRmOoNxwM80X6iPgbD2kDC6rJzBMQYb2aeBkShxacAb/pTAWc/XhTrJdH5wjy1IpMlz/0zMkS1LJIgIae/35/MwTV9B1zZfRV5CkoSI7xweTKZABW5k8Xeo/UCcg/f+wfOser+opk6tLsHp5O64kVlsvHPu5hvdRUByNkXq+MQi5b/iWFx3yfhzPgBsxLz7y8M/QYlDDzL4PfDSRxDDhtpmp+D9JTTuWuX21MpmQ/wT9XXknaYmP+GNv4ja7+BE2b0wY9lTcLzcuWDcG1YD3ISBsWRw8rPHxqCcDHuKikuXSVOW4m+GLxReycbW6gwhF3uCJtm9U7xEX6oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(346002)(136003)(376002)(366004)(26005)(2616005)(66556008)(66476007)(31696002)(186003)(6486002)(86362001)(83380400001)(508600001)(7416002)(956004)(54906003)(4326008)(2906002)(36916002)(8936002)(16576012)(110136005)(66946007)(316002)(38100700002)(8676002)(5660300002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUU4UzJheXJjdW5kSTg0dUNLWkYvOEx0ZzVMMnBFd1p6VmxOcU5uQU5Ya1Zj?=
 =?utf-8?B?L3Vma0RhTGMzRlVkYS9wR012Q25hUE82M2FxUEtvQTNrdTJnaDErL0VoNFFK?=
 =?utf-8?B?OHhLb0lUU0E5MlhaK2lHZDNlc3VzdUNINHZxUnM3TW5qMng0empTVU8xblFh?=
 =?utf-8?B?MXBjeHZML1hKUlk3dVRZU21zV0x1NmFOazdaUU5BL3o5YXEvQ3FCckFxVTZ2?=
 =?utf-8?B?UU1HamJKMTVuMVdxY1k5czRQZHJ6b0J4eXpaamRrc3h6bEpUNFRnS2VZbTll?=
 =?utf-8?B?TXNIUStrZDdoRXhGbzY1OUp5MHR4M0J5Vk9GV2NtanMyZXV4dkErekRxaTk5?=
 =?utf-8?B?SHd6QlRtSkMycUpFVFo5ZXdnVDFCQ2pXaUZ5Q3lqNHJaaHFpdHZweFk0WDNq?=
 =?utf-8?B?T2cwR0tNNElHczAzNFJYSWJCbzlBNG5aRCtZOHI0K0xWQ3BZQ1NMeGhhWE4w?=
 =?utf-8?B?SW9qSDBHZVNXT25TOU0rVUhXTGo2eVR0U2VJd2hoUVNMRWdDUVdUS0R2WENW?=
 =?utf-8?B?UUtyckdRSE91bjVEcW9kZWZpZkViYU03U0dFZk43SExjZk1lcSt2d0ZVcEFl?=
 =?utf-8?B?K2EraVdkd3NyUmJFdEc0dXZ0V0NlajMzVVhZSDNCVDRYSk52eFRyTk9mZVhy?=
 =?utf-8?B?MzZMNFQ2TDJGWWtrS1RlaitFNUM0ODFjNzJRcUYxTDhMQVl5TkpRTHBQMFZQ?=
 =?utf-8?B?UU9ndjRvNzc1QjdyU29PUWRBOXJNakY4NFVtUzc3ZGsxQjgvYjZyNjM1ZzJa?=
 =?utf-8?B?ZER6cG8rZjIwSWd6dWtSNEtSb2JIdHFGTldsVzh5QXQySjREejJYRnJuY3Bn?=
 =?utf-8?B?SDZtcVFNb2NRTG9RVmovSGRaOUNodFd2ODMzSVp1YktZaG9LV0d1UzhHbWFK?=
 =?utf-8?B?ZlJLMUlpZjJyMHNiaytITlJtTTBybHMyckMxRXFBS1VCbEN5NjdQbU5jRDV4?=
 =?utf-8?B?aHVZN3hZMEtBY2hmZGtLbUhkdFZJU3VUWGZBUGJPZldrTkxjV0JYL2xyNU5h?=
 =?utf-8?B?b2ZHc0FVY0ZveGN0QTF4N0JCbmljSHlrWTdRVVVJbVYraC9UbHNvWlRjY01o?=
 =?utf-8?B?ejJJZXF2T1BGdXdwbFVjek54S0c3SHgwMDRGMHFXRDNOekt0YnU1QW5WWXN1?=
 =?utf-8?B?eGNhV05reVJZem9UVE9qTjhkaU44bUFUcFVwSkFVcWZrMGV4aWRQUDBkWEYv?=
 =?utf-8?B?UkJEeHJvVkVkdk10VktKeklNNUFPVk5MS3pjcy9qR3hOTWFNUFc2ZytoUzBi?=
 =?utf-8?B?OWRaa2F3Rm5IVUFNU1o3WU9nRk9YZmFvNHVMV0U4aFdDVFl0TmdRa2gxc0NI?=
 =?utf-8?B?QkxoNlkxRzJYYWNicWZRbGNIU0xWdC8xdThlRFc5UkVBMVY4TkpGMzM4QzhU?=
 =?utf-8?B?WmltdG9SYmQvUTc3SWF1TTE2dWRHaXZNRDVGemY4ZnViYXRIRDJ6NmlqN2w3?=
 =?utf-8?B?MzJIQm0zZFk1MUdkTS9BeXp1UkRLQk15ZGdyM1dlbmZjYzhlSzBib3ltMmh3?=
 =?utf-8?B?c055bXFXSmlWN2ZVYVJOdjVDRzhJUGRyRWNzVVJkQ1Y2ZGEzbUEvb2hYaE9Q?=
 =?utf-8?B?cDZqME9mVEhYVlpmY1hnWFM2TXB3TEJzZkU2VUE5TW5KRDFRekpHT1luVmNj?=
 =?utf-8?B?TmJscmdxZWJRNDJTRmx0Q1VWTFN4VXJWd2tqUVU4V2F0d1RVMEdsQk1peS9m?=
 =?utf-8?B?cFNCeVh4Y2N0SVV0c0hDM3RlSTB4aHJCR2lGdW5uRVNUWjAwOTJPY3BYWnB1?=
 =?utf-8?B?ZE1xMVlhOTdiVTljNUtmdGwwb0UrWlp4ZDI1djZHTUZhYnM0SitXcm9mekRD?=
 =?utf-8?B?YTExNUNRSGt5WVNOeUxZTi96a05rcEhobllFR21CenRpQitBaFJqdGVlMzl6?=
 =?utf-8?B?alNXT0tuSkhTKzB0WU1CaHVnenV5NFNBUFZmN09hN3hiY09TV01weEF3MXJU?=
 =?utf-8?B?SVRRMUthKzZpUFAraXQwbGtqcnZiQkErNi94UVorYUVWUHZIRHM0VmVicDBq?=
 =?utf-8?B?Wk5CVjEzYyt3ODVmV3pqN05LMHpvMys5ZGZLY2JDcVhmK08zWWZibUNZYWJ5?=
 =?utf-8?B?c0hML3F1UXd2WTRTKzVDdW4zQTdDVnhFT3h2cERtbnBWUkJXelo0MXhFcnYw?=
 =?utf-8?Q?mpqc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3a9f8e-0ef5-4ef7-51f7-08d9aa911b55
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 12:44:05.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+wwXPSEQgalJ/I3/YheorSMbk571sRGTfVk+kwJPPye7z6MWQ1EiG6H/Vysqr3G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5241
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>> Ok, I see what you mean now, sorry for being dense. If we allow this then
>> there is a need to add a special value that means all/many states (such as
>> -1 or something such) so that a mux-control can be used simultaneously by
>> drivers "pointing at" a specific state like you want to do, and by the
>> existing "application" style drivers that wraps the whole mux control.
>>
>> I.e. something like this
>>
>> 	mux: mux {
>> 		compatible = "mux-gpio";
>> 		...
>>
>> 		#mux-control-cells = <1>; /* one more than previously */
>> 	};
>>
>> 	phy {
>> 		...
>>
>> 		mux-control = <&mux 3>; /* point to specific state */
>> 	};
>>
>> 	i2c-mux {
>> 		compatible = "i2c-mux-gpmux";
>> 		parent = <&i2c0>
>> 		mux-control = <&mux (-1)>; /* many states needed */
>>
>> 		...
>>
>> 		i2c@1 {
>> 			eeprom@50 {
>> 				...
>> 			};
>> 		};
>>
>> 		i2c@2 {
>> 			...
>> 		};
>> 	};
>>
>> Yes, I realize that accesses to the eeprom cannot happen if the mux is
>> constantly selected and locked in state 3 by the phy, and that a mux with
>> one channel being a phy and other channels being I2C might not be
>> realistic, but the same gpio lines might control several muxes that are
>> used for separate signals solving at least the latter "problem" with this
>> completely made up example. Anyway, the above is in principle, and HW
>> designs are sometimes too weird for words.
>>
> 
> This is almost exactly what I was intending to implement except for one
> more change. The state of the mux will always be represented using the
> second argument(i.e. #mux-control-cells = <2>).
> 
> For example,
> mux-controls = <&mux 0 1>, <&mux 1 0>;
> 
> 
> With this I think we wouldn't need a special value for all or many states.

But you do. Several consumers need to be able to point to the same mux
control. If some of these consumers need one state, and some other need
all/many, the consumers needing many needs to be able to say that. Listing
many entries in mux-control = <>; is misleading since then the binding implies
that you could have different mux controls for each state, which is not
possible, at least not in the current implementations. It would also be
wasteful to needlessly establish links to the same mux control multiple
times, and the binding would cause bloated device trees even if you tried
to optimize this in the drivers. Therefore, I require a special value so
that consumers can continue to point at the mux control as a whole, even
if some other consumers of the same mux control wants to point at a specific
state.

>>> One more question that I had is, if the number of arguments match the
>>> #mux-control-cells and if the number of arguments are greater than 1 why
>>> is an error being returned?
>>
>> Changing that would require a bindings update anyway, so I simply
>> disallowed it as an error. Not much thought went into the decision,
>> as it couldn't be wrong to do what is being done with the bindings
>> that exist. That said, I have no problem lifting this restriction,
>> if there's a matching bindings update that makes it all fit.
>>
> 
> Sure, I think making a change in
> 
> Documentation/devicetree/bindings/mux/gpio-mux.yaml, should be good
> enough I assume.

Well, the new way to bind has very little to do with this being a gpio
mux. There is no reason not to allow this way to bind for any of the
other muxes. That said, the reg-mux binding has this:

  '#mux-control-cells':
    const: 1

Similarly, the adi,adg792a has explicit wording on how #mux-control-cells
works (but being a txt binding it is not checked, but that does not matter,
bindings should be correct). I now notice that this is missing from the
adi,adgs1408 binding, but that's an oversight.

The mux-controller binding has this:
  '#mux-control-cells':
    enum: [ 0, 1 ]

The mux-consumer binding should probably be updated with some words
on this subject too.

So, all mux bindings need updates when this door is opened. And, in order
to add this in a compatible way, the old way to bind with 0/1 cells needs
to continue to both work and be allowed.

I think it is easiest to add something common to the mux-controller
binding and then have the specific bindings simply inherit it from there
instead of adding (almost) the same words to all the driver bindings.

Cheers,
Peter

> Thank you for the comments. I'll post a respin of this series, with the
> above changes.
