Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE295726B6
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiGLTxI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiGLTwo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 15:52:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140110.outbound.protection.outlook.com [40.107.14.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D591FD
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 12:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HngJD2EYKSkz92HTd+be47+vM2iCVWXwUCKYBWzpvwZVjHLOYYrqW8CyEnCmsUYuguVfM08X8xZPhw5mTH0AnB1+lWYh/jZ5J0NkPyf2c1N6njXHwnUfhSsR02JGD+wBP0OBNOivzLiVTif2iFEkCLzP2TmUKbxazAHV5zB+zDVQP6qdox/pNdgeEc4GZj4uSgGQVh4DddM1KATVRtEwLjllxoahYYJX5Lm2tFwKazCLsQrOLugOw3kDlYf24l5VHnJtGkLa3uSpK39ebbs66MDo7NTEbxKrWFrEutE4IxHU2Oh4PMPd8zQO5RfrU/WiAj/AguWy3049eO5oQiDAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kXiCiY3awFJgP68EhHdqQGVEffyyiXKgfwAW/qRn14=;
 b=E2eo6X+skX6Ek3g44rAtOS+sDhkkkZYLBma+siOHCk412k5ERfSgpnfvq+Scxlduxn3lj1VxNxx/pcLFHXhK41LwQTIU8r0yBPlfyJJWxrv63uRKZzpihC6MeNft6OCwh1gUL6xz7uaGh0P6PGHSkRxLtH9akikkiqv1x+sT5UBIT4Am7teWCQP0nN+t96bkJqJ5M798KosdPtM2VYXekES/qph7FlFek8pa3HMSOQxBych0MUesDDvUMqaxGRWBsNjLb645PTK3TFps7v5BaISYJ1V/ft8aLqs718B6UNpSospy1qaREzRWN7PBKcKq8vuds1Kq3StIXrZCE2qs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kXiCiY3awFJgP68EhHdqQGVEffyyiXKgfwAW/qRn14=;
 b=ZXCI4ybGIqcYzHSMc8jusXnmczRFXe1OhB2HAEVj8NkdsG+xeA0sfOC+woleGNxLxB4zX8/btdjuzeXt8Qck8haCVYfB0k0REfSgJWFwydiaB+5HLNPRYl2keRN3Eq896mMqoXwXRrc8BsR65XP1DKs2oMrim3Wrft5He5dyNk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by DB6PR07MB3383.eurprd07.prod.outlook.com (2603:10a6:6:24::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.10; Tue, 12 Jul
 2022 19:47:07 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::2d30:72e4:6699:4127]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::2d30:72e4:6699:4127%2]) with mapi id 15.20.5438.011; Tue, 12 Jul 2022
 19:47:06 +0000
Message-ID: <70cbbc94-432f-d047-1cbb-ba950c08e0a2@victronenergy.com>
Date:   Tue, 12 Jul 2022 21:47:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vcan OpenWRT
Content-Language: en-US
To:     Sergio Alberto Valdivia <salberto2000@hotmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1576c141-905a-435c-47c0-08da643f4c04
X-MS-TrafficTypeDiagnostic: DB6PR07MB3383:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UfcNFayQgppCqjchUDpB1HXpWyZbVfJqxTUGj2h2Lutg78LRInbgMAWLT8sdpLzXfa8hBgvJA+XhNHbcEpJXbuCGkvzihbulRn6muZZZCGXm1iNGtM1hCmfbABggp4ET8P9sIxyb5SCanWMZZWRBMJMJeoYobLjHNDbde+dRPQX5gv2R1+UHTfH0cdt6xr18gA1iZ3byAwA1DVVOjOjxYjOBWG+If0IUNqWv3eSNA4TZTJ+EvUjuH0jL9QVpYnesU5mi81Y3WMfDxqI+BjgUjTGYMkKL9LqiZMcnlcd60KE489eIfLC+pb/WTT1b2YLNcb/8ymk16zH6bzQFKzir4Gh0uj1eq3PqwWq2wyz1G9p7rR5Cx6BrIOHQ/gicTaMHGH5ys5CjRxEEaZJHCjCemBqacLjMJr2Y96yO+GYvwbzTA/d5DLKZVZ8vcApEMBVOAVxZuN5sgj74in+X+3t7EirW69nMAQrLA0vBY0L6gGz6R+amSd1HyJDU+yI2vHL0W3kK9CS0xPBWXo/SmrId1OtIhLb/Pysk0fkeB2tePrQ4jsdg7pkVnhP5fiNOCCSerWSoC9IxXfdhEtQohDTyiWlZSiOQPtdFErgrYCLlgACZkAc1knnYeofGJEwj8X6HzeuTDEmhuxsaaY84jNOSpgptwrRhYv7qgpnwKEFbwPFxB7iieUTAjjBFoO/p8N0YNk26Fjg9L7Ouw6hkqwR1X4TJNDWS2pObqGytUrmV5LuNVBBBsmJ0ggvklBYxB7TuMidMsZKfGRWWYSPgf4CsXlZGbAzNtBpK9eRixLE4YVNyhN1p/oL6kix24SHv08SzdvTivpDS5aTkMjTQbw3uGHe40Dea0UdQWUekuy8y+otyUXonbUuK/hi83DMNd1ar4e7tPuMiywjN7LcADH6FUHfSV+VG76ozWuPGeilEJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(136003)(39850400004)(6512007)(4744005)(8676002)(41300700001)(6666004)(2906002)(6486002)(478600001)(6506007)(53546011)(31696002)(8936002)(86362001)(2616005)(3480700007)(186003)(38100700002)(36756003)(66476007)(7116003)(66946007)(316002)(31686004)(5660300002)(110136005)(66556008)(43740500002)(45980500001)(36394005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25wTHRreXByT05GTXJGSW5UNkpndTR4cGhPRDlVUGNCVmF6a1BRL1pmZWFT?=
 =?utf-8?B?ZU42V2FNd25WakJLNWdrV1NVU3ZwQ0EydFpQNEJvV2dwK2x0N2dqR3VJNzg2?=
 =?utf-8?B?WnNTWGNzdWNJZDRBcktpSG1rSmJBYm9TcHU5VWpQbWNueDdVVmgzWkhTNFZJ?=
 =?utf-8?B?aGxob3JkejFKZ25MRGkrcUlCdGp2M25hK2Q4SGQ4azg1N1hiY1VDUGhDU3A3?=
 =?utf-8?B?cWZRUkRjMlJxbyt0NmE0OFFIUjA3bHN6RW5yd2Fncms3Y2trTlZOODZ4cTlU?=
 =?utf-8?B?S1UyV09FZlhsd3U2WWJtWkk1SkltQnJ6Ry9vbEdzRUpUUUxhYytOYysxRjlN?=
 =?utf-8?B?UFZlMkVmZ1BzQ2dUWEFBbnNmUFp2ZkMrb1RYRFZ6bGhjdzZOaFNRcytmVzd4?=
 =?utf-8?B?RlpRaHc1aWFaM05QeWFPZWRodk5aRUNoMzFIcnZlTk5IUzVER29kMXYvZFF0?=
 =?utf-8?B?dWNad1dRVGNHS3ZkMVNHak9RVzZPaGlWcFgrNVVvWDlsYmU3WGxHdm84RXln?=
 =?utf-8?B?Z0J3dHBiMDZ1VTByTkdHMlFMMUJXWkU5QlRVWVVDeHVCM2EzQUx0N3VqcHhJ?=
 =?utf-8?B?b202aWZnQUZiTVg4SDB6TGtVT0lRL1h4bUJLWUFjdkZaM2pZcjJHYWt6TFNh?=
 =?utf-8?B?YjdwNVlFK2U0N1IzcVZWWTdDcndCaHAxbkpjOTRaRS9HNWFhTWNnWGFyUHFn?=
 =?utf-8?B?Nm94K3VIK2R4UGhCczNNNWR0czI2S2N0S1N4NlFKcGxlY0p0TW82cnhMRmVp?=
 =?utf-8?B?K3A2S1NiWVhzbjdhSkNoZENMalZTT3pWYnBxb1FVWlVnT1llUUlreDdIL0FY?=
 =?utf-8?B?K1ZndkNXdFpsQ3hYalhvNDVQUzBjTVBKL3hvb2Y0WjRWV2t3R1FFeGlxTDFm?=
 =?utf-8?B?SHFiYzNUclVKU3FOTEd1NTdpaGZhS1B4WTY4NGJnWkZJU0RPdGV6aklHUUFo?=
 =?utf-8?B?SC9sRHAveTRBMkg5dC9SbXZuUkZlUFVOaEJ6V0U3UGgyZHBYT0hhM3FmNzAy?=
 =?utf-8?B?SDBFVWJWcGJrWWNsVXdCZUxOaUxDZy9nTWdhMy9ZWXdTVjEzK2tzcTE5aTJp?=
 =?utf-8?B?QUhZWFZ6ZmhTTUs3QmxmQzFpc2NmVnEyWW5KcWZVREpBM2dTTWM3cFBUalBl?=
 =?utf-8?B?L0RoS2o0ZHl0THo4a0xaMk1GaFd2MzlmU3Nkek1OeGFJeHE3dzlhbEFTNDFx?=
 =?utf-8?B?dDhjWjZiTis0M1BJb2JNa2U1dG1GdWFINHd3ck5xcmFNMUw2UE96aFc5M3Z3?=
 =?utf-8?B?WTNwRlE2K2VsNzY5ZktMOGsySEpxaXJtQWZvZTBQQ1lSUlVjUFcvSmZ5WXFD?=
 =?utf-8?B?bWdKQllkUHpDL3FwUm91S3FzZnczSTcwa0JaSWQwZkhXbWFaQTNFY1gyNFRJ?=
 =?utf-8?B?YVY2ZXVCR3ZleDE4aVpadStlRm8xTmVzMTZtYy96NjVYRGs5TWl6VVI2cm1h?=
 =?utf-8?B?d3hSbEUweHNrVEZNemRmN1VRSk5LNi82cG5OS0tyakRiRVBkcFpqVmQrUHFp?=
 =?utf-8?B?Nmp2ZHZQK2Z2YWcxTjdUS1RzOUVuOGpXdkdRMHNNVGJOTSt2VkVySTM2SHpZ?=
 =?utf-8?B?S3lhUDUwV3kyVDJJZmtweU04bFg5d2FBREczdks1aG1uWGdlMzl1MExMa3F6?=
 =?utf-8?B?dHBlaEF5czRrMTRweVo4RHRNdUZsbEZ6aTRqZXo3dXptcXB6Mi9PNTdycDlZ?=
 =?utf-8?B?WWVna2YyYXFJNkp1ZXRQK21TeHpReFVOd2o1bXNoak5hMUJPTFJRNzk5RENJ?=
 =?utf-8?B?T3pPbTdOellnUm5INjdTUnJQbW5zaGREVkVwcnE1VHVPcHVzT0FLWjlBcXA1?=
 =?utf-8?B?YXlYUFpHVWpxMzdvYXdsWXIrRzl3Y2h0MHlObHhQWGZWN0h1ajhnQ2h2THRQ?=
 =?utf-8?B?Z1hhSVJKbFVwMzJEUmpWbUdHYWN0dVlhQnhtSmptUDBRSWorNFV0M25OYklN?=
 =?utf-8?B?bU9oU0NOa2Jab2VtSjBOZjlOMDBQcWRvUHJpZnlVMWJ4ZzArOXlhYWhQOWE4?=
 =?utf-8?B?UXhHUTZiTkVrQ2JXMldCR1dPeC8yL1FiNko3YW1GTnlkZGJLMWxXcGZEK21V?=
 =?utf-8?B?K2lRU2hKVjZYcDRqSEt5R0dhOVcxaGdhOVBMQ1ZmcDlkUWdpa2Y4dG0xem5P?=
 =?utf-8?B?aVlSdVNlWUljbEQ3U3hhSG5yMjhabnNUQ0tEeitaZURuQjRubVVmY2dOcTZE?=
 =?utf-8?B?VGxMSmY1K0ZBMHdaa1dRL0c3TzFPWXRUcDNQMjFQbUFEUnRrbDhUNUZ4OFJR?=
 =?utf-8?B?SzlqZm9SMjJRWmNFNkRUWWYxcllBPT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1576c141-905a-435c-47c0-08da643f4c04
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 19:47:06.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +09Yfx2jvi6sVRk0wOH9TwKM6sgSgQXRPhmt9cQUcokUkk3f1j+h7pUTEwKPKUT/wN0mqKrwKpZ8EGYfB+cyiB8Ib+ZHRN3j6F72BBUmjmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Sergio,

On 7/12/22 17:41, Sergio Alberto Valdivia wrote:
> Hi my name is Sergio, I’m trying to use can-utils in an Onion Omega 2 pro, which runs OpenWRT.
>
> I have already installed the can-utils packages, but when I try to create a virtual CAN interface I get the following error: failed to find a module named vcan.
>
You should ask the OpenWRT folks to build the module and make it 
available or build
it yourself.

Regards,

Jeroen

