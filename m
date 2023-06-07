Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57F726199
	for <lists+linux-can@lfdr.de>; Wed,  7 Jun 2023 15:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjFGNpr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Jun 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjFGNpp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Jun 2023 09:45:45 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BD19BF
        for <linux-can@vger.kernel.org>; Wed,  7 Jun 2023 06:45:39 -0700 (PDT)
Received: from 104.47.11.176_.trendmicro.com (unknown [172.21.174.129])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 3A7CE100017A8;
        Wed,  7 Jun 2023 13:45:38 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1686145536.965000
X-TM-MAIL-UUID: 242d8b1a-b478-494a-ac51-5782f0bcbadb
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id EBE241000BEB7;
        Wed,  7 Jun 2023 13:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhSu7TjdK/CK5puyHN8/vH3RNemUO+EtsGPWCFkMZkGyKLodSbjwD9FkPgSradp74TiKS3v1yUvKfDzjPNFW2xScU4sqVJsMt5kQ9CFLF3RE71nMhDMEsLwDHuxvw7cGCSW7bC8m4c90w5GVKE6KX8/yQ+NvPH0dIZ57jqoxo8MVW0k4/QtduRd/VlOFyUHv1bjCrnMe9ifT8diUjrYYgJhb4fZ6yzGIuTkBdJpAuFScR+w6YysbO6EucVVCOP2owQbEkruPCE3Fd1fPTqEcVwcSJBUk08V7oAzyJFeF0B6HfA+d3eI37Lc4HJk4681Xt3rk0P8obsFe1lqgBDGD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPpfcJS3zw26n8rBAjASOg17fIc8jit2Re90D5GWPv8=;
 b=c+/jW8x1+UNhjFk5RA4Gsyyp9ySIYe19zEm4sYC9Es0G1VoGFdDsTcq9eYKkjQ1VipDO+lyRPym2CdiH16ckAVn6dl8LnWL4XClOv9KbixVe7k19c68hHjs6SB+S705SDANWzqpR4MImwSE+m4qWiTYRbUE2/Z8F8blVbLwLk+w7H39gapSNUEq1tr8t2/yKMz7GB6vVRAq6IBOa0MpA/gKkos6Mn0klT9fmqQfGI0+uMJxZS6B+9qSLzKpNAtLkGVB2Ydkmsv9NaTj1yJQlz9ZE9+XmFrFC3qVxt/KpeBAlqlcrs++tagbybu6lya11k/IxH4a6R4kYD8y4E2GFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7f10427c-cad4-6eeb-31f0-e39ccdbc38ab@opensynergy.com>
Date:   Wed, 7 Jun 2023 15:45:33 +0200
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v2 1/1] virtio-can:
 Device specification - 2nd RFC draft.
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
References: <20220825133410.18367-1-harald.mommer@opensynergy.com>
 <87o7tj2bgd.fsf@redhat.com>
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <87o7tj2bgd.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::33) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|BEZP281MB1862:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ded9bf2-1681-4705-8f63-08db675d781f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjinyUfA+vgmlpSzD0ZijfbmloG5vPtYtD8ozpR8WS3CoOuYk4244frhkajbirHHbf8I8PXMB8r702MrMBnP7bqo+k8NTj87z0D8Z5T/j105J7JLPHMHX2C5/xCRNVr2QHhEW3My4rSCJEWRBIAW6YMJihefQFEiGlh29niZCx9p7kumc4SmV7DeDw29cQSPHbgQZ/oDPFTAN97itS8r6baoRoyQDAX3NvtUBHqWkszeSY9d28iXxjcm9Saw/1u19q6r8HuvZ16kH2e1JVQCjDH5xzp1wWRj0E7Wg7PZh5aAOZJx5B5tY9BMgMJP8lehZuPJYdaWprMWrNwxTt+WkF6/tQo7ozR6hod6F/eddlM2fvJhIF8hvVweuGBtsltUVEOx7pzMKa4u4YJ2JwAKwHxXOJMJwHUqjMaA+hA5NcZPu56JmIVoAIhB8w8gZqbtejz4xq/ACUhlyhJj20HC25r8y6bR8ue962cWpF9mKPIp7KVJbimBcy/vjKIXCNDgbhyF5n9gKeidKBNTNrWOwQo5J32Q0rBtbP4Zbx9/nha+x5Mw+ReBfesfFBBJXFXY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39840400004)(366004)(396003)(136003)(451199021)(41300700001)(316002)(83380400001)(31696002)(30864003)(2616005)(2906002)(186003)(86362001)(36756003)(8936002)(8676002)(26005)(53546011)(107886003)(44832011)(5660300002)(38100700002)(66946007)(6636002)(66556008)(66476007)(4326008)(31686004)(478600001)(66899021)(110136005)(42186006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9pamxueEYvQXUrT2tpNDhkMVlVMHZQNXpDQ1hZdmJMNEdtUjIwclRzZUJo?=
 =?utf-8?B?Z1MvODBtdk5IdVM1UDYrc3VjdjhEamJGNEhWNG1HbFRaSkgwT3JBN1VLMkhv?=
 =?utf-8?B?WEJRS2xBMjR2R1FRL01NbC9iZVBzSWk1VjhKQkdTaUpzZGJXRndndHFiUExE?=
 =?utf-8?B?cW1ZRzhEVUVMUFkvbUJiYnNUa3lrT3hPWmtVbHpxU2dTSm90RFk2V1A2ZjI5?=
 =?utf-8?B?eWp3dkRjRjUrRlVrUHM5SlZsNDFVc2t6K0doT1VHZWlqY0VxeUk0ZXF5alFm?=
 =?utf-8?B?dWRLRlNEWHM1TmFJTExaNEszUWFvK1dCSlpBQzlCc2lCUldkbllTTnZEdDh0?=
 =?utf-8?B?QVV0THZIZ2pmaCtBVUx5UEdIQkZPOXN2VVJLRWhZa0kvNkx6U1l3Z3Nlc3pP?=
 =?utf-8?B?Y2pDYUFMQmd1b2lxenRWSVN5T2tNUEJwVTV3Vzczb0tUSkVXOUR3M3hnRit2?=
 =?utf-8?B?TllWeEZuRXFBNWFtMXk0T3JpWk5hbk12ZERaN2FJNEpRY0JHUWU5TnI3bHpZ?=
 =?utf-8?B?eVE3QlFjNlcxTi9FbEMrMWpHRXQ0R04rbUhuU2tVVm5FQ3hmTzhiREQrQ1NS?=
 =?utf-8?B?Um1vaWU3bno2Tzl2YnFobFFyL0daY2hqSnd4Zkt4WmJMNzcvMXZ3cDhXYThR?=
 =?utf-8?B?RjlXM1JBNVI4UEhNM3BrTjJCTlYzNUhnWXlYdEVTZlEzQ3ArbEkzYTQ0T2pH?=
 =?utf-8?B?WE5GQitZRTNJWDFJZ1piNlBzQXBwK2o5MXdBaUdSMks0bjBiNGE5ekhjbkE3?=
 =?utf-8?B?VEQ3ZzZMQzRNSFpEb1ZuL0JWd0s1a3BEQWcrN29QTnppd3hqSW1MU0RBWGhz?=
 =?utf-8?B?UmJQckdIVDlwaFgvZGdGSXlUd1R1WGlFdU4xUUVQa3NJVFBIUERXdlByOHJF?=
 =?utf-8?B?bWozZmlWZHF3MnhqRjgxY041dW5sa0RDTVlrSk9OS2h5d21sK1h4OERWQU9n?=
 =?utf-8?B?R3M5SDRqMW1LeTgyZ0lLVWw3cWVvZktlcS84b2djZVd2Z3YxZWZmUXY4ck13?=
 =?utf-8?B?cXlnb1VZeHZCV01WK3hldEFuenY2YUxEMU9YTElGZVNrQnFpUWlMVUIxVFhM?=
 =?utf-8?B?Tnh1bTB2RFVzbEoyakdoZ0pWRkRZMkRiTk5Sb1lSY0hHUTdJMVdlNXhjby9t?=
 =?utf-8?B?d2tBaGx6MWRZTUNXY2Y0M0ZjVnoyYVZLNFlxaVRERjFZeVNZbm1zSllkejNN?=
 =?utf-8?B?em91SHQ4bVdpOVVLUXJ3SmRnZGpzYWhLb25TNnB5VmxjNGFZNEsraTJMZUp4?=
 =?utf-8?B?ZXRRN29LOURIM2NpTjFuOGM0OWVvWFREUk1IeG8xWGtYMGc5c1ZuZFRjblJq?=
 =?utf-8?B?c2krdTNwakt2TEJ6ajVnS3RFRFJVMzhSbUIwcDBwSGk1dmU5SGtiNDEycWVX?=
 =?utf-8?B?UWVaYUtvRU5BWmxzL01mdUlnVk93blNlRWo4aW1wTUdGZDZzenJwV291Q1hj?=
 =?utf-8?B?Y3BidmpmSzl4ZTE0NlgvbGE2N3RKTnNhUG9HUzNJUmhXdnRKUFc1QjlnaUJw?=
 =?utf-8?B?MVYrV3ZPeXg0MnZrTU5tZDhOZWVaNnJDcENjU2c2YlZyb1VPYmhjRndiMDIw?=
 =?utf-8?B?czF5Y0VPbmRxeWd4R0hiQ3N6ZE1Ia0JOQjVrSHhoUllnYy80TWlXWThhMnEr?=
 =?utf-8?B?VzQveFRxTFBYazByR3I1cTlodVFOSUlqNE1kSDJnSzYxY2xiS1Z0Vlo3cEk0?=
 =?utf-8?B?TzNPbWg2SVBWaFlIVjYxM2FKajlJRC9mTVVBazlvOHdlNnBCbytBVWlkRXlm?=
 =?utf-8?B?QzFOUlBrZ2c3WG5DdXlCNkRqRzc2OXN5V2xseVpneXlzU2UyM2FwcEJ5T0pa?=
 =?utf-8?B?RXNqcko0M1F2bzBFTlI0NEMvNGlRSXFmdlYwRVdncEJQUUtTVmRZRUFoQjhQ?=
 =?utf-8?B?L1JuM2NTeWh5S1R5bHEyL1lzdm8yb1hWcG5jc3NoWEpMUERxNU5EaGx3V1Zr?=
 =?utf-8?B?dS9iSE9mZXhrUXU4cGwya0ZFcVVZZ1l6WEVtRU1GSkxWakpzTEVXVEZ1ZC9M?=
 =?utf-8?B?NTZrTzYydTBEZ24zRXNpRzFyOVdGYzhpNzdHajhPZmdzR01raG5mMGwwM2ds?=
 =?utf-8?B?QUFWeUpNN2dBNGcrelVSSVBuMlpvUTRmT1JOUlVtaHdrMWpCNnAxclpkZDJZ?=
 =?utf-8?Q?HitiM8IB98mhN+dbt8lad691o?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded9bf2-1681-4705-8f63-08db675d781f
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:45:34.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqMrL/kXw3JEMlnk+cmaD+KBUZMWZtVSNPvwGc43OR6YNFns1JUbGdFjuzO21v5zdYgEbWvtS0F0Ek3eak3YMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1862
X-TM-AS-ERS: 104.47.11.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27676.007
X-TMASE-Result: 10--38.639300-4.000000
X-TMASE-MatchedRID: CxmI61mtwh+Mp9w0tjqOxd5x7RpGJf1a1mCNgDTpXhXIgofMgahPrZtC
        OUPy2BVao+TnyuCC+KomWHBGwAt/Xg7Qbfq/wswqEVuC0eNRYvJSHjB5Y+o5ZOfdksK3etFJxL0
        I8900w0/RrskJdnLrDpJC/hDZR97aHsYi+P4ETTXtP6Pv+A+w8xSJ8houaz8CdE7HIe9l0mwUXK
        izhC4rw+mNDYS3tqhl0y/8v+EKfsjuCneWeJlGLy0x8J2DopENKQNhMboqZlrfghYDxv+lXUIcj
        CJ1jCYKDxjbRLHqaOcbK4UnVFqVx/V+NbN27IZWuFdP7vaalM0BqNb4Qv6Vo/4DDXoaCqk7zQoS
        tblJ+ZaMNUzDpMm+4RAeb/zzdHPt0TQv27eiyNyXmVAzMqYX0nFd5+Cf9M1DJ9yE4ZdtVDdTdkr
        +Aa37ovPcaNUrGkgkXaeXr3D3sbGPs+eYYUC8WkEOfoWOrvuORIcgbn8wHesM74Nf6tTB9o/MVY
        +TBf96FeTJ4j1iQa0fKGvOmyzglAzijwbEm3oy5p1ddw6V4RsJlr1xKkE5uSIIO0VwKeOLgK6qC
        Ga1Z9ci+t+0AiFaYsrbguuTTSDuTBhdFGvbKafcgUVP3Cp+vd7bZy1Qv3MzK/KIKP1Nsl85Qka/
        B296ol61PZtF3q6L1mLuCemy7OOvnR5n5ZcuUdlPBaMvTruGRpgtqnD1BD4JvvL2zxdK5BZaDvo
        iUT/MhUL4GbQQ5L3GnTx1mhQsamGN6M1vhJ4HxbAoZFyXeaFZDdHiTk9OcHfeQuKj8hz+ntU3Lv
        5Rb/3EjqhE7rH88Wdz8URVjst0MEXvbHOEks1ANB89sV0bJ0pO/ORUaZ3FmyiLZetSf8nJ4y0wP
        1A6AKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TMASE-XGENCLOUD: 7e9b65ef-e82f-44b6-8d35-9a2aadb22a53-0-0-200-0
X-TM-Deliver-Signature: F0A21332F18BEE43896D3FD521A6BD4D
X-TM-Addin-Auth: rya6GsAOUAzZNEbdrv5UKKx21crXXc0J8F3SU8PbiZrcbP2hQ7EqPb+ISyi
        hwn0T2s0ggnD6vUqMHdY5gMs55xVtBiPRjc8lukkyW2pBq+ySS8OVsZrDX5gu2DYpc/TOebzemu
        lXMJBxMIJuWIHbhohmkwPInxAiQDOR5w733d81nqu33BPkLhUgWxJWwoIQHWwGl4HOhdDZ9nks5
        lyzcutvJoeKULm0fH0b6rVMOsscCZfT082lAd0wQO+a0b77gIeu3i6UsbYjC+UtCrLgzzJrl+NX
        StciPxRAnPtcBm0=.M5fCAFufZOTvyAfw1X7o4fryp9U6dkCicHB5UYK7ZkraLAW9tWQWDb1hlv
        nD/MytzrES8QHmidOKo6nMOrzh4vCPSF6aXbCAEe5OWrUYaHqJNrn9UqT620Q0c7jCRcNSKkmId
        2GqYSRBJLIA1dtR55NLCDKZ+svV4KkD4d0Giuq3ymBFnefDZc70gmVM1+WCo01l1d6Ei8jAbYWd
        7uiQpRfc+dsD+C/tRMqJsA+M34lPoNe4H/I2joxQ34NYwsyjPJVT8H+bLfXwiYoAYu2zY05SX50
        J+aklE+fs1aV13zTMpW3pcEb0/VGb6sQ5aOli37Ey3wUzz70hNgQh/z3sAg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1686145538;
        bh=uVabhZ6aAen9H+5qDmz022AqzVuKvI0qfGTABqVEpTI=; l=17809;
        h=Date:To:From;
        b=Y+ZKiJyX7tcw4Y5hFCqqGBh8F+XUpOD1YH+eL3i3Q78Q41GUhkFCRtryRMlsad6sO
         pirNRFslvbZtgxyHd3yaa1IfVzFm3xuOZLwDjJjx7zQTaofI6xgjQPxCrABU8Oso29
         Ce9xkRqbG44YlHAR81CTUrC5SmLE/EPTzgi/AjZVVHnW4oyW/gqfEqaO298M5k5uul
         hYcBV/fbdn+JiYegQzIDvJ+PLoP/V06NmPxMOLjTBgiuydJloULs+9ZlLVLZGMtlxB
         F/fxD7iSP6a9fZRYDdXH9vLiAEZzzX6RBngjcng0Uz6BDyrBk9DdUe2icp0vFuaTZf
         5jAvHPXl6EDOA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

there was a printout on my desk for some time to go through and address 
the comments but the E-Mail I did indeed not answer yet. There should go 
out in the next days a reworked specification and driver.

On 07.11.22 13:30, Cornelia Huck wrote:
> On Thu, Aug 25 2022, Harald Mommer <harald.mommer@opensynergy.com> wrote:
>
>> virtio-can is a virtual CAN device. It provides a way to give access to
>> a CAN controller from a driver guest. The device is aimed to be used by
>> driver guests running a HLOS as well as by driver guests running a
>> typical RTOS as used in controller environments.
> Note that I'm not familiar with CAN, so I'll comment mostly from a
> virtio spec POV.
>
>> This is the reworked (2nd) version of the specification after having
>> gotten some feedback on the virtio lists and the Linux CAN mailing
>> lists. (The 1st now outdated version of the specification draft has been
>> sent out on 1-Apr-2021 to the virtio lists.) There is now also a virtio
>> CAN Linux driver which in the meantime has become good enough to be
>> shown.
>>
>> There were a lot of changes, only mentioning the most important ones
>> omitting editorial changes.
>>
>> - Classic CAN is indeed non-mandatory, so a feature bit is needed.
>>    According to ISO all CAN controllers support classic CAN but it may be
>>    disabled by configuration. So classic CAN is indeed a feature which
>>    may not be available in some environments.
>>
>> - Introduce a new feature flag VIRTIO_CAN_F_LATE_TX_ACK. While marking
>>    as used after the actual transmission has been done on the CAN bus
>>    this cannot be implemented reliably in all environments. SocketCAN is
>>    affected at least under heavy load for TX and RX.
>>
>> - RTR frames were requested on the Linux mailing list. They cannot be
>>    supported when the underlying CAN driver backend is a 3rd party
>>    AUTOSAR driver as AUTOSAR CAN does not support RTR frames. A feature
>>    flag VIRTIO_CAN_F_RTR_FRAMES has been added to make support of RTR
>>    frames an optional feature.
>>
>> - Add le32 flags. There is now a reserved field in both RX and TX
>>    messages which might serve to contain an AUTOSAR hardware object
>>    handle or similar in a future version of the specification without
>>    need to change the layout of the RX and TX message structures.
>>
>> - Removal of priorities and config space. Priorities cannot be supported
>>    using SocketCAN, the information delivered in the config space cannot
>>    be determined using SocketCAN. Support of different priorities was
>>    anyway too much for a first version of a specification. If priorities
>>    are supported in a future version there will probably be only 2
>>    different priorities, normal and high. In a future version of the
>>    specification high priority messages may either be supported by using
>>    a flag bit in the TX message but most probably the better solution
>>    will be to add add a dedicated 2nd TX queue for high priority messages
>>    in a review comment. But as already said priorities are not for now.
> Please keep the change log separate from the description.
>
> [Most people add a S-o-b, although we don't enforce DCO.]

I understand neither "S-o-b" nor "DCO". Neither Wikipedia nor Google are 
helpful, nothing fits.

>> ---
>>   conformance.tex  |  27 +++++-
>>   content.tex      |   1 +
>>   introduction.tex |   2 +
>>   virtio-can.tex   | 229 +++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 255 insertions(+), 4 deletions(-)
>>   create mode 100644 virtio-can.tex
> (...)
>
>> diff --git a/virtio-can.tex b/virtio-can.tex
>> new file mode 100644
>> index 0000000..ef4de7b
>> --- /dev/null
>> +++ b/virtio-can.tex
>> @@ -0,0 +1,229 @@
>> +\section{CAN Device}\label{sec:Device Types / CAN Device}
>> +
>> +virtio-can is a virtio based CAN (Controller Area Network) controller.
>> +It is used to give a virtual machine access to a CAN bus. The CAN bus
>> +might either be a physical CAN bus or a virtual CAN bus between virtual
>> +machines or a combination of both.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
>> +
>> +36
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] Txq
>> +\item[1] Rxq
>> +\item[2] Controlq
>> +\item[3] Indicationq
>> +\end{description}
>> +
>> +The \field{Txq} is used to send CAN packets to the CAN bus.
>> +
>> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
>> +
>> +The \field{Controlq} is used to control the state of the CAN controller.
>> +
>> +The \field{Indicationq} is used to receive unsolicited indications of
>> +CAN controller state changes.
>> +
>> +\devicenormative{\subsubsection}{Feature bits}{Device Types / CAN Device / Feature bits}
> We usually don't put the whole feature bit specification into a
> normative section, especially as it applies to both device and
> driver. A device normative section is for statements like "The device
> MUST offer <feature> if <condition> applies", and a driver normative
> section for things like "The driver MUST accept <feature> if offered".
Reworked.
>> +
>> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
>> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
>> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
>> +specification.
>> +
>> +\begin{description}
>> +
>> +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
>> +
>> +The device supports classic CAN frames with a maximum payload size of 8
>> +bytes.
>> +
>> +\item[VIRTIO_CAN_F_CAN_FD (1)]
>> +
>> +The device supports CAN FD frames with a maximum payload size of 64
>> +bytes.
>> +
>> +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
>> +
>> +The device supports RTR (remote transmission request) frames. RTR frames
>> +are only supported with classic CAN.
> Are any combinations of those three feature bits valid (both to be
> offered, and to be negotiated?) It looks like F_RTR_FRAMES would only
> work with F_CAN_CLASSIC?

Without VIRTIO_CAN_F_CAN_CLASSIC no VIRTIO_CAN_F_RTR_FRAMES. Added.

>> +
>> +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
>> +
>> +The virtio CAN device marks transmission requests from the \field{Txq}
>> +as used after the CAN message has been transmitted on the CAN bus.
>> +Without this feature flag negotiated the device is allowed to mark
> "If this feature bit has not been negotiated, ..."
Replaced now not only here but also in a later chapter.
>> +transmission requests already as used when the CAN message has been
>> +scheduled for transmission but might not yet have been transmitted on
>> +the CAN bus.
>> +
>> +\end{description}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Initialization}
>> +
>> +\begin{enumerate}
>> +
>> +\item Read the feature bits and negotiate with the device.
> I think this step is redundant.
Removed.
>
>> +
>> +\item The driver MUST populate the \field{Rxq} with empty
>> +device-writeable buffers of at least the struct virtio_can_rx size to be
>> +ready for the reception of CAN messages.
> virtio_can_rx is only defined further below, and, IIUC, depends on the
> frames that are supported. Can this be expressed as a kind of absolute
> value (depending on the negotiated features)?

Made a forward reference to the chapter where the structure is defined.

I could add here a a constant but nobody else is doing this in the 
specification. 2 le16 + 2 le32 = 12 bytes + max payload length. (Will 
become 16 bytes instead of 12 bytes in the next version.) With CAN 
classic the payload may have a length of up to 8 bytes, with CAN FD the 
payload may have a length of up to 64 bytes. The max payload length of 
CAN classic and CAN FD are mentioned at different places already, for 
CAN people the max. payload length are fundamental constants they know 
anyway. All is given. 12+8 = X for CAN classic and 12+64 = Y for CAN FD.

>> +
>> +\item The driver MUST populate the \field{Indicationq} with empty
>> +device-writeable buffers of at least the struct virtio_can_event_ind size
>> +so that the CAN device is able to provide status change indications to the
>> +virtio CAN driver.
> Is virtio_can_event_ind always supposed to be an le16 value? If yes,
> it would probably be easier to specify that here.
The indication queue will be thrown out. An extra queue to indicate a 
rare event which could be represented in a single bit in the config 
space was considered overkill and the indication queue also caused 
headache with certain race conditions we thought about.
>> +
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
>> +
>> +A device operation has an outcome which is described by one of the
>> +following values:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_RESULT_OK     0u
>> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
>> +\end{lstlisting}
>> +
>> +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
>> +
>> +The type of a CAN message identifier is determined by \field{flags}. The
>> +3 most significant bits of
>> +\field{can_id} do not bear the information about the type of the CAN
>> +message identifier and are 0.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_FLAGS_FD            0x4000U
>> +#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000U
>> +#define VIRTIO_CAN_FLAGS_RTR           0x2000U
>> +\end{lstlisting}
> You refer to the "flags" and "can_id" fields, but it is unclear in which
> structure. Would this benefit from reordering?
Put the flags now close to struct virtio_can_tx_out and mentioned for 
struct virtio_can_tx_in that the flags are the same. Should be more 
clear now to what those definitions belong.
>> +
>> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
>> +
>> +The general format of a request in the \field{Controlq} is
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_control_out {
>> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
>> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
>> +        le16 msg_type;
>> +};
>> +\end{lstlisting}
>> +
>> +To participate in bus communication the CAN controller is started by
>> +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
>> +participating in bus communication it is stopped by sending a
>> +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
>> +confirmed by the result of the operation.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_control_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
>> +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. The device marks the request
>> +used when the CAN controller has finalized the transition to the
>> +requested controller mode.
>> +
>> +On transition to the STOPPED state the device cancels all CAN messages
>> +already pending for transmission and marks them as used with
>> +\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
>> +device marks messages received from the
>> +\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
>> +transmitting them to the CAN bus.
>> +
>> +Initially the CAN controller is in the STOPPED state.
> Is that an internal state of the controller that can be changed from the
> outside?
Can be changed from the outside, this is the control queue sending 
VIRTIO_CAN_SET_CTRL_MODE_START to start the controller or 
VIRTIO_CAN_SET_CTRL_MODE_STOP to stop the controller. And the controller 
transitions from start to stop on certain error conditions on the bus 
which are indicated by a bus off from the physical CAN controller hardware.
>> +
>> +Control queue messages are processed in order.
>> +
>> +\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}
> I think this should be a normal subsection, as you describe not only
> what the device needs to do, but also what the driver does. Maybe use
> separate normative sections for MUST statements?
What I have now in the reworked section is that I start with an active 
descriptive sentence "The driver transmits messages by placing outgoing 
CAN messages in the Txq virtqueue" and subsequently talk about the 
device. Could be ok now but I might be wrong.
>> +
>> +Messages are transmitted by placing outgoing CAN messages in the
>> +\field{Txq} virtqueue.
> Who places the messages? The driver? Probably better to use active voice
> here.
This is the descriptive sentence now in active voice explaining what the 
message is and where it comes from.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_tx_out {
>> +#define VIRTIO_CAN_TX 0x0001u
>> +        le16 msg_type;
>> +        le16 reserved;
>> +        le32 flags;
>> +        le32 can_id;
>> +        u8 sdu[];
>> +};
>> +
>> +struct virtio_can_tx_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +The length of \field{sdu} is implicit in the length of the device
>> +read-only descriptors.
> Not sure what this means -- does that mean that any length of the
> desriptors is ok, as long as it fits the whole structure?

There is some information provided how much bytes the other side has 
written. From this the payload length can be deducted without having a 
length field in the structure itself. There were some more comments on 
this, we thought about it and now we have a le16 length field in the 
structure. More clear and probably more future proof.

However it was strange behavior / worth a warning / need to truncate 
when more than 8 bytes payload for CAN classic or more than 64 bytes 
payload for CAN FD were present.

>> +
>> +If transmission of a CAN frame type is requested for which support has
>> +not been negotiated \field{result} shall be set to
>> +VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
>> +transmission.
> This probably should rather be something like "The device MUST reject
> any CAN frame type for which support has not been negotiated with
> VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT schedule the
> message for transmission."
Reworded as proposed.
>> +
>> +If \field{can_id} or field{sdu} length are out of range or the CAN
>> +controller is in an invalid state \field{result} shall be set to
>> +VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
>> +transmission.
> Same here.
"shall" => "MUST". Done.
>> +
>> +If the parameters are valid the message is scheduled for transmission.
>> +
>> +If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
>> +transmission request MUST be marked as used with \field{result} set to
>> +VIRTIO_CAN_OK after the CAN controller acknowledged the successful
>> +transmission on the CAN bus. Without feature
>> +VIRTIO_CAN_F_CAN_LATE_TX_ACK negotiated the transmission request MAY
>> +already be marked as used with \field{result} set to VIRTIO_CAN_OK when
>> +the transmission request has been processed by the virtio CAN device and
>> +send down the protocol stack being scheduled for transmission.
>> +
>> +\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
>> +
>> +Messages can be received by providing empty incoming buffers to the
>> +virtqueue \field{Rxq}.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_rx {
>> +#define VIRTIO_CAN_RX 0x0101u
>> +        le16 msg_type;
>> +        le16 reserved;
>> +        le32 flags;
>> +        le32 can_id;
>> +        u8 sdu[];
>> +};
>> +\end{lstlisting}
>> +
>> +If the feature VIRTIO_CAN_F_CAN_FD has been negotiated the maximal
>> +possible \field{sdu} length is 64, if the feature has not been
>> +negotiated the maximal possible \field{sdu} length is 8.
>> +
>> +The actual length of the \field{sdu} is calculated from the length of the
>> +driver read-only descriptors.
> So the provided descriptors must fit at least the size of the structure
> plus whatever length the negotiated frame sizes support? Can the driver
> negotiate F_CAN_FD and still provide descriptors that only allow an sdu
> of length 8?
Negotiating CAN FD and not allowing for 64 bytes payload would be like 
having an Ethernet device not providing enough room to receive a 1518 
bytes frame with 1500 bytes payload. Means this was a bug.
>> +
>> +\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
>> +
>> +There are certain error conditions so that the physical CAN controller
>> +has to stop participating in CAN communication on the bus. If such an
>> +error condition occurs the device informs the driver about the
>> +unsolicited CAN controller state change by a CAN BusOff indication.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_event_ind {
>> +#define VIRTIO_CAN_BUSOFF_IND 0x0301u
>> +        le16 msg_type;
>> +};
>> +\end{lstlisting}
>> +
>> +After bus-off detection the CAN controller is in STOPPED state. The CAN
>> +module does not participate in bus communication any more so all CAN
> s/module/device/ ?

Yes, device.

(And the rarely used message will be eliminated in the next version 
together with the queue in favor of a single bit in the config space. 
Already mentioned above.)

>> +messages pending for transmission are put into the used queue with
>> +\field{result} VIRTIO_CAN_RESULT_NOT_OK.

