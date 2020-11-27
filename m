Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA22C6923
	for <lists+linux-can@lfdr.de>; Fri, 27 Nov 2020 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgK0QJq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 27 Nov 2020 11:09:46 -0500
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:40271
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730985AbgK0QJp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 27 Nov 2020 11:09:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw+hpVdhUTA6t+2/ilpuxlYzDIP4tYudtMMBGKYIAej92qa4iCV+oInSQFhtSHk6HuXcYvCB0KLJbJYQL/IjkXgyVNtS/XubG1YskJvYl9GJoifRLMOf3+900dXjZtmWlR9CzfM5La+QuM++5D6OplN0RGq/loLdlzZBBqRGGXKZlNUSwYMBbqSpfa9wBfdqNuVemKFCahplSQzYfqChvkI3Ejp+gzfCAaiFna9oX0KBTvV+8RfzhvNzeKOJubBGZzWyKaeXMNP1amygYBKmvvoP7SunUbNlnHO0pOckST6Y7Lm0PHDT4d0+Zqzgshw9FwViPhuNXbSkHSnxlFRdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3axviFeqFPuGKi5ZRrl3vy17mxKfk0qncszG4x31VQ=;
 b=Vzj1e/s5q1lT5lGy7E4cquoxUlhn+4u9OX4u6RSSEcz4yppim2YS5C1uJqwKGI9Uk3XwBNMDMA9hUbaiKFr7/fWg2pzpJbFWyb6OkLXaGfPEBX6pQoJqhxfkTceTkEgJNZ2DlYDB5zI8AU4wL2lvGdVDy1e5BmcEWpSHayeM7kxFQn4kl69FYOOqcEKzFGYTucCPf5S9B8HezUqTAKdq7ka+/Qo/GE1yE58bCevebA/d3kCNNDEvoPkpA2hREStcCc4sh4eOz1PufJLyK18qs+XLXYr29u2vECMSXLAHEn9cZgWqPN58crwJ3t89cve7/n93OI6ZzPF0z3fI15j4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3axviFeqFPuGKi5ZRrl3vy17mxKfk0qncszG4x31VQ=;
 b=bHILOrtombN+KM2pM50DS8zdCgcvpQUAvEOfFAO8g5cNhRyyQ6izd2QGDixUnz6Z5XsQ4zq/Bh1NvVZ+WaydtKjqR0Km9dXanCWIvkNfi+U0Ad2nmrFHc3SLJQNE1xlypF87mwYA1prX72154r62vmfeo/zYYmvO2zhpRdxWsdY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=victronenergy.com;
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com (2603:10a6:10:192::11)
 by DB9PR07MB7098.eurprd07.prod.outlook.com (2603:10a6:10:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11; Fri, 27 Nov
 2020 16:09:41 +0000
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c]) by DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c%3]) with mapi id 15.20.3632.009; Fri, 27 Nov 2020
 16:09:41 +0000
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: rx-dropped increases if the can module is not loaded (yet)
Message-ID: <269cc265-272e-6b57-0f95-90a3bd66aea3@victronenergy.com>
Date:   Fri, 27 Nov 2020 17:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2001:1c01:3bc5:4e00:e791:efe6:bf00:7133]
X-ClientProxiedBy: AM4PR0902CA0008.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::18) To DBAPR07MB6967.eurprd07.prod.outlook.com
 (2603:10a6:10:192::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:1c01:3bc5:4e00:e791:efe6:bf00:7133] (2001:1c01:3bc5:4e00:e791:efe6:bf00:7133) by AM4PR0902CA0008.eurprd09.prod.outlook.com (2603:10a6:200:9b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Fri, 27 Nov 2020 16:09:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551bcdaf-59c0-4f6e-6ff1-08d892eed934
X-MS-TrafficTypeDiagnostic: DB9PR07MB7098:
X-Microsoft-Antispam-PRVS: <DB9PR07MB70984176937670AC459F2E8BC0F80@DB9PR07MB7098.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zVHA+XDnvRjS2rxKXEpkJZQDMntXQ3Z7efMC3W3Sb9xtgQzltXvgfItfK7DqATHIqai6nHNmIVcgZ9RMs4ydzC6q/SkscawWOxjXwAv/L2P4tF/V/mSmnZBNX40UVjDQJMOTJ+i98PtnkpvYmNAAVVELI2WmmWzUxD98TnGcMrQxoPYH4Wxdc3G1cvpHX3I5/tk2VVMlmU0IxZlilLYMuI4WKFEpEkCX/3fMN8LyqLULKvXm2xjWJVVTb3UIBBGHe2XZoQtP6iXyJsCwoj6w9DAHyIIgWiM+rp9c0CgeUzlLGWLJI71NWUDD7jcsH3a/WDKLkV5eJ9nFsX92QLLdalpQMwTBcLcnfLmPYCv2Bf1AAYKdsiWJzk2uziuLcmAja76C8uO3PphfTo93KiaMf55fFyj74VaqUJrq6qm3riBGX6dJYXtiILnPuOIZPjaHwbcBr42/8vZTCQobWNVJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB6967.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39850400004)(66556008)(966005)(8676002)(186003)(6916009)(478600001)(36756003)(8936002)(16526019)(4744005)(2906002)(83380400001)(66476007)(31686004)(86362001)(5660300002)(31696002)(66946007)(316002)(6486002)(2616005)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3hqSzBLaDI1WFhsQjRpcWxHWkRtd3BqM3F4RmdURmVLRFhSeWUxMUtnMnBt?=
 =?utf-8?B?ZWFlQ3Z3cEcyelM2ZFZzN0E2YSsvZGRCdEd4eWhCN2JHSmhmY29KU24zc3hY?=
 =?utf-8?B?bll1R2MxV2hJUGRGMEZyelhiaUNKNTZkKzljZVU4WDh3Y21aSVFCNy9KdlJV?=
 =?utf-8?B?NHo1TGszVFNrWUpZc2NjTGFpMU1hdW5qNFhRVVorc1N3eXVNdUU4NEdmczRk?=
 =?utf-8?B?TWFPTXR1dHJNbXZweXAzMjN4VDhzMlY4ZkJxQjcwV09XZEJWcU1hNHJpdm44?=
 =?utf-8?B?THU3NVZkU1JSa3R5UFZGSmIyVCtieHBoQk1ZYWZFa1paWUhaREl4cm1nMGhq?=
 =?utf-8?B?NTZQekQxVkxUbmVpSkJZSGZ2QW1RR2ZaRkxrMERuVE9jRWw5YzJXZkl0Y29K?=
 =?utf-8?B?N3IzMG84TUtzV3NBMXhMbU5lYWlmNmJGUTJIaXp3OEY4SGpBN0ttWWZrcHhs?=
 =?utf-8?B?RXZUaGtiRVExbTQ3b3ZXQi9oRlgxdVY5RXpYbG03UFF1eDVYWnRDUENDa0JN?=
 =?utf-8?B?dUkxZzJDTFhjdVkrSlJHODhKZ0NndVRGTENGUmVuRHJaZktuTTkweVlsV2J0?=
 =?utf-8?B?QTBOZFRqbkRLSnl5UElmK0IvT1o3MXFvd1daUkJPczY5UXdRdXB3UlFlMkYz?=
 =?utf-8?B?NU8xNSt2bmdhbWQ3eldEQ2FYSGRzZlNvZGw1S1FMRWVvWUZ0a3owd0NiWVhv?=
 =?utf-8?B?cU4rYlJRNEg1UEM4ZUwzR1JtV0VUV0xzWmIzWnhYVm9oNnlqSGY2WGhmbGZj?=
 =?utf-8?B?M0F6aVhLUURGSGZvUzN3RFA3RVVsTFhLZXl5dFBoVC9SakVLK3VNSGJyUFZ3?=
 =?utf-8?B?bmpzRmdpTTR5ZE9Rc3cyblpwNWlNSm5zekpXZ3lzK3NDWFBqWUVYNW1Xc2FV?=
 =?utf-8?B?Y3ovM00wOFNyKzd1cW1HYkNFRlViNTNZbUFmZS9hRmpqZ0JkL1pKNEttOUdQ?=
 =?utf-8?B?UjR2YWJiLzBkT1gzcFVGd2J2Z0hNNTMxOEJ0TVFXMzU0aFhGVXlIRG42VFRM?=
 =?utf-8?B?QlpjVGpBeHlBWVVJQXhZbXpuUzkydS84VVN3aldkQVJWOTY2ZE5NUGhUcmVx?=
 =?utf-8?B?Wk45aGFXUmZRbk56LzBHTThVd1V5bFZKcUp1Y1plb3RMSGJvRithdkJKbGFO?=
 =?utf-8?B?eWJTVlk2ejVPeHlVb0FQYm9mTnNDQTFUUm95Y0UxUnJOcmVjcXFtMXk1dXB2?=
 =?utf-8?B?Z2JUUmZMNVNEV0JoeXcvSXR4ZFphYVpNYUJ3dFJibWRDZnBZejFzMzJOZFh3?=
 =?utf-8?B?aTBPRWdEN1ByMjZyN3hFV0hTU05HVFZWeVJ6aTVLTEVOa2xqNUpRN0lLRXdW?=
 =?utf-8?B?ajNydzVBakhHbE12SVFWYnRYVXgwN3RLQmJwWnFWNFFwT1JZc3EzS0J2aUt2?=
 =?utf-8?B?Ym1IRGN3SGdZK3NyYVM4WjVIazNybGhNd0lQcFNzU0NwVTkvYkZsazlFUnNq?=
 =?utf-8?Q?QjS1j8GQ?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB6967.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 16:09:41.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-Network-Message-Id: 551bcdaf-59c0-4f6e-6ff1-08d892eed934
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy0AB2isVnhhWWl4+TO4XUzfzYolvnBi2bperwaZasvr9D5cbzsdhMUP8nZYwCOsduumDH4sCDZGyyOfeK4+HuHYywHIRIhTQkTShVKnRpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7098
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Since it took me a while to figure it out, it might be worthwhile to share.
If a CAN-bus network interface is first set to up and only later used,
the messages received in the meantime are counted by [1] as dropped.

If the the can module is modprobed before the interface is upped, this
is no longer the case.

Perhaps it saves someone some time.

Jeroen

[1] https://github.com/torvalds/linux/blob/v5.9/net/core/dev.c#L5257

