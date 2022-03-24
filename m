Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D344E635A
	for <lists+linux-can@lfdr.de>; Thu, 24 Mar 2022 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiCXM37 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Mar 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350199AbiCXM35 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Mar 2022 08:29:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5738A9947
        for <linux-can@vger.kernel.org>; Thu, 24 Mar 2022 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648124903; x=1679660903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sFHkS/VCriX4WLF8Gr/d3v6VxsE1K1u/mghLBg3RJk8=;
  b=dpYBsg+nzZz5Jf3MdX5sXoE1/xGPOcFWwuG4idTve4ZoOP61VAxShLGY
   5yNOu+7rR66BZHTjM2Nh8QuduqUyrHd5loK4eqoiPA/B8jXXNEJCJUKEy
   9v3DqKa5quVb9V8Jioi+i+qr+5sesStFY9ZNBUGiqZKqMkniOvmtspCcq
   MwpFVahhg6t2wo2IOAp+3CFECOLsIL72VSGeSFkem3mPe5AaWjepcoHZV
   OTOZRSZl4NKCtKa9JF2SES1t4gbC8jsXxA5I4dlJzo3foqq7mE6GMU/ZC
   QTzL7ta5/A3pDDa/ZZvmo3WAXhqwRTRy8M2sZ9zW078SSPwqGY39UKBNO
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,207,1643698800"; 
   d="scan'208";a="166972717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2022 05:28:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Mar 2022 05:28:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 24 Mar 2022 05:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUsGevPWN5iPjX5iPUYCYRAWsb+0l9m15PMjm5fVIVJ9cYdXmGbecz0ZZemDi/7pJbODbGf6Jy9+MNaNwZSAqTcJKoc1JodS2bse6hZk9JcY9+1YbAo+ArsfucAXEPzqYNIDvKrOuIQdZVWXMS4HehCL+/tduA4b7aFnjmgQgcie2M5gy4CHsx1TVa2W3ORrxfvVCAbNKPuenD6JOjCioGDz2cpBdPFOHWeQhrtxdgv3KHGjXUox1VZx+a2aGCdBkuzOWwMS0T9skttAji6eDunsmTSMPZJ9yKnlVSPVI3IfAL+lRxTL/5Sz3UfwF2kw2X8MNzOyl58pgks7/BDI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFHkS/VCriX4WLF8Gr/d3v6VxsE1K1u/mghLBg3RJk8=;
 b=DPzJ0E6fBxLbwTJnGpJbcRDxakJHd625VfSmdnulyBhqjZOQXuOgSw7pFC9JN6ZVK0Ntp0CrXrZ25l4xXKjl/lCEz1ExHmmBEI3gP2LNyqIohoGyFcAGqKahE6AMIMpVM2aQ8p9MvgH7101P6eXwXVoNdg/e9Rjhs+7dqhlzLEnkWgOXX8lfIfXb50BhD3tO0GqQiT/IdeoGe6DCIjxkLyh5qF8biwW1bg9Nv8utxcBSd3Ql0kIbEnk1pCFNf1393nWgd0td1XF2JlRwEvl7Yg2VC24H0nGYRmEXN0CaGDGKKBZ68x4Yxl0na+N2WSZ5ipRj/mWjyvPOuWN/oKMOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFHkS/VCriX4WLF8Gr/d3v6VxsE1K1u/mghLBg3RJk8=;
 b=VxV0TtLfNrgjzRkaKiDgGGiqnX37mWTQRD98jo+psJENPvRajw40IHv3IEO8tqHGHaY9lF4lJymNKfD9fUco163vqfAhzbiHwxjTbh9Z5PjmD+RhZ2LxMWYueUm4/IqM/j+t4hMvkoltJDXVduBxAhSMOTl3/uHjOzb/NqENHe0=
Received: from DM4PR11MB5390.namprd11.prod.outlook.com (2603:10b6:5:395::13)
 by CH0PR11MB5363.namprd11.prod.outlook.com (2603:10b6:610:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 12:28:10 +0000
Received: from DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6]) by DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6%9]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 12:28:10 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <kernel@pengutronix.de>,
        <manivannan.sadhasivam@linaro.org>
Subject: RE: can-next 2022-03-13: mcp251xfd: add
Thread-Topic: can-next 2022-03-13: mcp251xfd: add
Thread-Index: AQHYNrV85eXBoW8fO0uqUGXLZ/3mU6zNAK7wgAAPiICAAA/acIAASwAAgAEcwYA=
Date:   Thu, 24 Mar 2022 12:28:10 +0000
Message-ID: <DM4PR11MB53902541ACA7F003887D7915FB199@DM4PR11MB5390.namprd11.prod.outlook.com>
References: <20220313083640.501791-1-mkl@pengutronix.de>
 <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
 <20220323140347.hkuklvkefvb4l6l5@pengutronix.de>
 <DM4PR11MB5390224F4ABAED6DFC430266FB189@DM4PR11MB5390.namprd11.prod.outlook.com>
 <20220323192858.pixhyf2jzah7eqiv@pengutronix.de>
In-Reply-To: <20220323192858.pixhyf2jzah7eqiv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744015f8-099d-42ec-5021-08da0d91c218
x-ms-traffictypediagnostic: CH0PR11MB5363:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5363C25BBA6E0CE8DFD2B269FB199@CH0PR11MB5363.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGscJMzm6nZ79NR0JGmr+kB+h37trDr2Hf1qYHb/IMj6xeYp2f50ZZuTLwwTQH/o0+XgfZf+XEz7XhChK2hwViWqGbK1GpPcRAG3Jnz/GPpUrrfk/7GDXXWIfEffvXMoTxyYqmGxY9iB0/oA6GMcLYFCOdMNaOHuFLQUM6PaWnK/uBh2OpsHZkcG0kXTSwh4T+o4zJu0MaWOPuHh+MHlKXlCI/7xSPiQPTm6H8HGGY5yn1xNz81P6kLjf93+L/gyijcihj1DYgbk936FWG5FhdWOmofzxjjWjXoba6DP7swyrzUKMiqSgjPwJdXhSq1gl3dp1gvmMZuhWL7sb5vl2gTBPejpieU2jRyAj70lH7RB/x6CYgMquv6HSFWRcUrVRUwDNUWCtwwGqhM4OVmHXXSU+crDqUE301+hoBeDAg2DLi/w/Zc3xGLk4asE/NheztI7WcQtvzQjLFlnyq+C4eTNNazUVBuFy/wtlRBfIWQGLnAw9Qthbttm4av8hJ1HlbabNI2f4FLxRFZ9J4wEAV+Mt/rZappPaf81jcWY8LFREOyy/yYu5+wu04IKKXfpk1NwolD4ksfgwP0VwFAswcHh+MIul3ShCAVm68wzqNyMf9SXYlfFjTRfi9hkYyp6di6StdXla61Vm9B19BYgoN/QvCT/Zjxv0mgbNjtCXseLhiYt1KELsPy7bw8nlYREGTIc3UTgM/XOurec32uvBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5390.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(122000001)(2906002)(52536014)(8936002)(508600001)(55016003)(8676002)(64756008)(66946007)(4326008)(33656002)(66446008)(76116006)(66556008)(66476007)(7696005)(6506007)(38100700002)(6916009)(54906003)(316002)(83380400001)(26005)(186003)(9686003)(4744005)(5660300002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNSQjhnNFFZYkRwbjhSV3VzYmNzYmZybEs5dnVMckcwb05MZzF0d2h1M3ZC?=
 =?utf-8?B?VEtqV2grVGFGUDV5ZkhmUEc5RTZDNWZaNERBTFcyWGtRNzg2QVN3Ym1lQjFx?=
 =?utf-8?B?V0VCRmlFYm1mOVIxckZkOERYaVlGNVdpaStBU3BDUUNYbC95VXZXdDJrYUZy?=
 =?utf-8?B?MzdReXJOeXZrWDY4STNwVGl6NDBENHl3ekFpejVFcTZWRzlMcnk2cWxuL1dG?=
 =?utf-8?B?VmUxdHhCblo0bnluYis4OHlQakVKRlJacmx4TkY4Mk5Sb3BjdUt6dlZWS2h1?=
 =?utf-8?B?SFdKNzhyOU9GZituS211aGZ0Z3V4Z0FSbVJnbXAwU1o1SjBaaGhVWDZ4L0RE?=
 =?utf-8?B?bVNtbTdlTUZaLzdQalAydXJCbWxlVjB4djhzMVFSa0VPczJPL0o1bWhwRmQ4?=
 =?utf-8?B?ektGcXlmQ0dxOExQN2tSMk9wTUtYZy9aVVBFenEzUHEvZlR4Y2RDdmtiUzN4?=
 =?utf-8?B?VkJPQTBjTEN2NmNDODY1aVZnei8xNmVqeVBFWDRjNlB5V0t6SHN1M3ExMlkx?=
 =?utf-8?B?QUtzaUcrTDdKSlk4Yzg1elZsRnRrdlU4VzhmRWYvN2RBRS9zZGRubDVVV0Ra?=
 =?utf-8?B?WDdVbzFpbENtcTNScDI0YnR2VmVsTlA2R0k2NEpQQnZGTjRCa1BpdHdjWGR4?=
 =?utf-8?B?MlFSdG9naDlvZzlSYzB2Q0lldmpmdmZvU2phTVBleGJoQSsreGJ1TXEwMmtT?=
 =?utf-8?B?UEpXUVFzNnJaSXBaSExDNUh5OVh0a0hwVlJmUFBtVG1xTWJqNlQzVzJoVmE4?=
 =?utf-8?B?WVF5d0h1UlFBWHEwaml3M1c3ejB6K3hSdnFjZ05yaFMwNDYydVhIU0U2N1Rt?=
 =?utf-8?B?eGNSaURhNEk1bWtXZlZDNVgvb0h4cmhreFVadlREVzUxU3V5bXNJdnhWdlRn?=
 =?utf-8?B?aFd0M2UycUYyeExqYnlNd3lvOVpLSzNLWFlCQ3U4a1grTFMrMW9wa0pYMWlF?=
 =?utf-8?B?RW9nbFFpN1F3ZG5HU054cFdMT0djRTdRMjltZUtWa1lUQ3VEMnl0MmZielMr?=
 =?utf-8?B?ZXNhdklOZmNITDhiWGY0MlorRmN6N2YyUUFxMVArMTUyMWtSYlJoQlJEUGtP?=
 =?utf-8?B?RHNkWjk2Uy8yWHU0aVRNUHNWWjVjSlcxUTg3QXBNZ3lzR2dOcnJUOGRERHpx?=
 =?utf-8?B?L1N3NVJhNTgxZ3BScFlKR0RZcHBHYmcwcWZQS04vTTlEZGxxbk1XdjZhdE9t?=
 =?utf-8?B?eGdzd3BaYXV6Y1k4ZmFxZm5LckZoNDRCeWhqU1RvaUJoZURvUlJpd3dqa0E1?=
 =?utf-8?B?UnBnUDN4eHlKSWlZT09uUlE3b1cxaUxuMnFFRzVXazdNclNSNERXaURTVkRx?=
 =?utf-8?B?Rlc1dDFDQXdKMmNybU5YZDdWQWlBMzNzNjEzb3loOVZVZmJGdWs4bXJwTGhB?=
 =?utf-8?B?ZXFzZnBVMlVkcmlDWXFyTDNjSFpvTzVlb2Y1bFdPUzdWS2ZWcXQvL2xkK2Nw?=
 =?utf-8?B?RVFQYVpZQ2doOFhiYVcvdFhDbmdLZTlEUmR5elhRaytRNlRvazZxMG0wenlz?=
 =?utf-8?B?c01jR0lkbXJYb2Yrc3FYWFYvL2lJMjA3UjgweWhtKzV2d01zNVdGUVUzWm5Q?=
 =?utf-8?B?d1RNSmhlU1ZCL2hEdDB0VFFZSGU0TW5BeXBDZ2lyMWJERnIrY3FrNFlpcEJR?=
 =?utf-8?B?cGxDUkdNaWFwbk5iTlpJMHcwclMyQnFlSGdkWVRKekg1RklsUlE5WE1OK2ZZ?=
 =?utf-8?B?Q1dOdnZOeU5udHU3NFNwNzJ2L2JtV1o0R2RzWkJTWUVsZWJwN280dzdPN0dB?=
 =?utf-8?B?c0RPRnVHVFRGdXQxcWJsejJEQzBMVHRwRm9nTEtIdk9pbTRBb3ZvaHBQRkhk?=
 =?utf-8?B?bmhNdEZyeC9kS1NrRjMyQkU3ckFSMDdVbWd0L1ZmSDdhWnpLbk5VZ0U3VFps?=
 =?utf-8?B?UGx1SGY5eGxsMXVGUHdYWWRqLzQyV3JydE93QWxLMitMOVlmb3FGZUd3SUpY?=
 =?utf-8?B?WWtVemYxVm5velk2SHByRDkrbzJNazIzU2hueUZaY01xQktMMzZXOVpHR1RU?=
 =?utf-8?B?anpMZTRnc0p6MFhuYXBwT3dITWxWaE5QeElWSHF0VTFNcTlZVzBFYklpUlVZ?=
 =?utf-8?B?YnUzSkVWd01QVjVhTFYyeW5tYkN2dEp4ZFNDaFJNZHZEM05vTHA0Ym5nZlo0?=
 =?utf-8?B?bXlLRmlwWWQ0SWk1aGd2eXVtTVBMNi9MU1FnN1NXQXVsM0dsRUYzM0phY3Jn?=
 =?utf-8?B?RXE1MmhHTmNlcVBQUDI0UUh3U2gra1QrUUNESGJRUXdCL0pXREpVTE1NYnF6?=
 =?utf-8?B?UXhJa2xTamlaM3hxc2VnT1BSNXNDVTVCZWxBZFpWTmN6S1VSZFlOZmlUelhu?=
 =?utf-8?B?Z3RRTU5zV0lTWlFZb0p5R1lKQktydFlYbWJzUFZINkZPUllGZkZWdHBEKy84?=
 =?utf-8?Q?f6MNWqHRgz+07ozk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5390.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744015f8-099d-42ec-5021-08da0d91c218
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 12:28:10.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoaqae/B1vxJbxGwJYijykJ8cXXmznV90+esNk6atHdv8T3uPH8/mVQ9AXfTNK5Ntkm6qf+IqZqJkMJZHkiuo+JLggMIpC33FpUWdYFlTAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5363
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+IFllcywgd2lsbCBkby4gRm9yIHRoZSByZWNvcmQsIHRoZSBkaWZmZXJlbmNlIHdhcyByZWFs
bHkgbWFyZ2luYWwuIE9uDQo+ID4gMjBrIGZyYW1lcyBJIGhhZCAzOTE4MiB2cy4gMzkxMzkgU1BJ
IGludGVycnVwdHMuDQo+IA0KPiBJIGFzc3VtZSBpbiBzb21lIGNhc2UgdGhlIFJYIHByb2Nlc3Np
bmcgdG9vayBzbyBsb25nIHRoYXQgdGhlcmUgd2FzDQo+IGFub3RoZXIgUlggQ0FOIGZyYW1lIHJl
YWR5IGluIHRoZSBzYW1lIElSUSBoYW5kbGVyIHJ1bi4NCg0KSHJtLCBnb29kIHBvaW50LiBOb3cg
d2l0aCBmcmVxdWVuY3kgc2NhbGluZyBzZXQgdG8gcGVyZm9ybWFuY2UgSSBkb24ndCBzZWUgdGhl
IGRpZmZlcmVuY2UgYW55bW9yZSBhbmQgc2VlIGEgY29uc2lzdGVudCAyIFNQSSBpbnRlcnJ1cHRz
IHBlciBDQU4tRkQgbWVzc2FnZS4gU28gYXQgbGVhc3QgaW4gcGVyZm9ybWFuY2UgbW9kZSB0aGlz
IHNlZW1zIHRvIGJlIHRoZSBzYW1lLiBXb3VsZCBiZSBpbnRlcmVzdGluZyB0byBzZWUgdGhlIGVm
ZmVjdHMgb24gYSB3ZWFrZXIgc3lzdGVtIHRoYW4gdGhlIFBpNC4NCg0KSW4gQ0FOLUZEIG1vZGUg
SSBjYW4ndCBnZXQgdGhlIGRyaXZlciB0byBhbGxvY2F0ZSBsZXNzIHRoYW4gMSBGaWZvIHdpdGgg
YSBkZXB0aCBvZiAxNiB0byBSWC4gSXMgdGhhdCBpbnRlbmRlZD8gSS5lLiBJIHRyeSB0byB1c2Ug
ZXRodG9vbCAtRyBjYW4wIHJ4IDggdHggOCBhbmQgaXQgc3RpbGwgbGVhZHMgdG8gdGhlIGZvbGxv
d2luZyBzZXR1cDoNCkZJRk8gc2V0dXA6IFRFRjogICAgICAgICAweDQwMDogIDgqMTIgYnl0ZXMg
PSAgIDk2IGJ5dGVzDQpGSUZPIHNldHVwOiBSWC0wOiBGSUZPIDEvMHg0MTg6IDE2Kjc2IGJ5dGVz
ID0gMTIxNiBieXRlcw0KRklGTyBzZXR1cDogVFg6ICAgRklGTyAyLzB4OGQ4OiAgOCo3MiBieXRl
cyA9ICA1NzYgYnl0ZXMNCkZJRk8gc2V0dXA6IGZyZWU6ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMTYwIGJ5dGVzDQoNCkJlc3QgUmVnYXJkcywNClRob21hcyANCg==
