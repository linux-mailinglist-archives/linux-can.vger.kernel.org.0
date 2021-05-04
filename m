Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58D372A69
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEDMyN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:54:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37235 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMyN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620132798; x=1651668798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c4YoWu2t+BpDqO3Bd7FW6RIIt/DUo8YXoWpDpJJO4F8=;
  b=G34RQOOPgXacGbVVOxSPI2uMMOpU5LshJVic3RVBhZBhhrpZEilf7Wt8
   P49SFc1Z5O3tjDRaRGWOUW9MnLeItF0/UXRC61xaJGTn7lJ+vsD/CotVW
   rzyTe9wl4N3KxLw+dPrYrOnplyJCz6BwDuhS7r1qoB8XY15U/MJ3YuI9h
   97zX3K1Gickpbc0pggyrC6MzNNnDDND+MksHk/KpRxdPDOCN7bFIeHaUT
   oDTT8TkFzF4L/y/OfQlwXyxDqK0an+kipHBuQwwyMFhs0jN/8rg+rDzUG
   jkbgBY0+snaP+OBUngxGh25HvYPyvZx+/CMowdm1932IKypEmebsx4lls
   A==;
IronPort-SDR: 5UttuUwj2TDjF32ZMeqInMG6Q/iCvvh0xfFbptpfud4ULxFcZfrhirW6lbLI+jMPT/z7CWdmZr
 0c2S6ikSF7QPZN4+ySlVVxPfS/evU7qHJOMX6QzP26SnQj2dSpdz2hmUNrnTKbsffbXUPxuYPU
 KcZSTSpDw7VdeBBSrDAb/TDAW1pYQDTeJ7L1EBxxSz7AtF2yNes7+8NVGDp9XNKi2mKKl0WMMW
 54x0mpcy7ioN1YaPm3h1gu21r8YIYDIIvyNwsme69/iBAvG9ptALx9DES4gtPreA4pwqitbJ57
 lBc=
X-IronPort-AV: E=Sophos;i="5.82,272,1613458800"; 
   d="scan'208";a="119417433"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2021 05:53:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 05:53:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Tue, 4 May 2021 05:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMa5f/myF5+Vl4Is+AMeZRwBPzlDRei5sOECJH7v5FoU/Cg1cojNMSfyfbfbvpW9Sv/u+Xnp1CvHirpo0LyC/Lna7WvrU518QKiToYJOgFTva8NuE41plL+Z+YB/dx5IsEmOcdtoBzkS1GJ24VsWsIi7Ax5Ty7Qi+gFW3fcdMQhn18+J4nzJDlzEAwr4Uh9TJvn/Ez6MhunUmQ8u4ByNnsljQEPNSMoea443aN4MD4d28YtHTA04IhGOqTPiArD0FpdoB8TAVGfri+29WQ1QZqr+mNsGYEmN7/ADuFBUAOoWUumpQiDau7wVDcQdfdPiB/L3UCmCdlE26Jx1iKHaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4YoWu2t+BpDqO3Bd7FW6RIIt/DUo8YXoWpDpJJO4F8=;
 b=h4sgX4nBvJDwLXeh1Be2UcxSYceI1CO31iVtC/qZv0VtSFen0ZCkatNRI+uTgXfwWF5gs+xYaa/JQh/ePdINy1KG1gozAJXJ3bsBiIz6/Cd86HCOLGFovYJTgkqilfhjn8MpUYhGfKjfR4I5cIb6JxmLjRRNe7K2wjHgOzZS1ZXDl9ZfBIA/t9Hu+lGivM+lMK3ABQyhtnEBoR8DnKpiYe26f++c/cjeGMazSqwgQC1gj7Y+MliON6ZN1eHweYihrRv+gcEvYxuuHArCWZZGhTE/SJ3STnLMPM7TPw1RfkNu5EPmocEczWgnqWZUt/kYBDUhRTopBAOXphP56jZX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4YoWu2t+BpDqO3Bd7FW6RIIt/DUo8YXoWpDpJJO4F8=;
 b=TpBK4tr0qII3WRmifAa6UEEO/tGBbA84n+X5cm2+E3F3g5KHVxeznXuaUO3IQI8poyMRA2zRyAnKe8kChPBRcQ1bC2KP+RU5Tht4Y6lpEbRyHeUNPupu+TW+fFBwCrsNiDqeyEDSHBEAls3+l1euGDUOYUWTHKz0OOdVnbRs43o=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 12:53:16 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::69f9:3846:267a:f22b]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::69f9:3846:267a:f22b%7]) with mapi id 15.20.4108.025; Tue, 4 May 2021
 12:53:16 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>
CC:     <kayoub5@live.com>, <linux-can@vger.kernel.org>
Subject: RE: mcp251xfd receiving non ACKed frames (was: Re: More flags for
 logging)
Thread-Topic: mcp251xfd receiving non ACKed frames (was: Re: More flags for
 logging)
Thread-Index: AQHXQLnqa/pgjsrYEEeu7QW8EWznKqrTPt+AgAAGZQA=
Date:   Tue, 4 May 2021 12:53:16 +0000
Message-ID: <DM6PR11MB42835BBA69260C24BEAECA2EFB5A9@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de>
 <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
 <20210504074834.tki7gzr6wz2le6o3@pengutronix.de>
 <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
In-Reply-To: <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [109.193.159.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49251d54-d3d2-4a27-a434-08d90efb95e3
x-ms-traffictypediagnostic: DM6PR11MB4721:
x-microsoft-antispam-prvs: <DM6PR11MB4721DD8A95250C0F9EF202A0FB5A9@DM6PR11MB4721.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70N/5mRe3ARxUvi0Xk/i2Msd0rxa/0yhaeWFlribIYs4p6LomPAwezXf5zlG9e+5d7Dpp+Qubpy3Y74wP0KTJ4xssVjwG3I2dwywssy8uF1Du+Ce45NxyTb9w+UGcXZxpfJ4sFnHULR3lbOK0LrQS0FTUi6yN2blZ+o8opN+hkRzwoA0eSZJFpz0O0xCWfnlmGacwLErx0pX6Uoh2sCZWckyfU77umjs0S0mAsQEcLVSmkNyTsP+yWFi3MFNEidYx50TRpixp6Js7M2MfUWDJ4mCB1BY4CPVV0/gcA/b4EBByBbmZRnP4XBv3pGBxrTzYRKCi8/xC57biYXaO3bYjdSWoXIcBBK7BPusfAmGjIJs/sjqRGFFT8TH1/BaDf7WPnvZb6QPfgeES31vAHmVX1jDRWyFWpafwa2dX7mp/LXUCnhlrvfntc9qMBE3ZDr47L41l8Xl+QT5W3582dgFcW0sN6VQjZGp/H8aGY86D7m/M4cSjdNZZKoiH7jzkfeth1SGJ+CX2bKSPzPn7W6SF5PMcKkhpL9teJOe5N18KsHgGXlU1pcKKBZPk1X0gSuhbyKXlVcwPvSKGqAyNJKW40Wm3LxgHi5YN3yBB3+Tmgquv/eRQO3d3CUZ0cX4QIYcLA3+ZXLazqY8Iut7PNwk+wXbQqgqiQ4j3YiD3zdKsE/zgoymec1IrfLdURd1DdF0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39850400004)(396003)(83380400001)(122000001)(9686003)(66946007)(66446008)(966005)(66476007)(26005)(71200400001)(66556008)(64756008)(76116006)(7696005)(2906002)(478600001)(5660300002)(8936002)(6506007)(316002)(55016002)(54906003)(110136005)(8676002)(38100700002)(4326008)(86362001)(33656002)(186003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QmdUZDhndEtjNkNSeVRZRHFpOURhV1NVOWV1NU4zRXdCVWc0N1lnVU5qUnZT?=
 =?utf-8?B?S0Y0UDVpWXNKYUdhRHAwWWFUbFZGNTJUMFJXTGprZWl6ai91K21GVkJRck9U?=
 =?utf-8?B?SThGOVMrTi9QMTQ2WkdncjZob2R6ZXJpL2lURjkxRkNOYkVPaVBZaWtWa1hk?=
 =?utf-8?B?TldManRCVTlMNHNhUjV0eHVaWFdTMHR0M1VjclJ0dlJ1RkNIME92cEs2elMz?=
 =?utf-8?B?OFNsVWtBNHpoWEtTWENHSCtQdEp6TGtyUkF6R0hmamdZclo5OC9tZmV1bWVE?=
 =?utf-8?B?MHRQSDRIcWVRSWpiQjhTR0IwRUJOUVB0NlNJdG5HMGFYZmhFUlgyUS9oOWFH?=
 =?utf-8?B?eEdKZnQzempIRGVFREg4eGx2QUlSeCtWQzc5OWpBbi9IMXpoRWJFTHpoeDgx?=
 =?utf-8?B?VUlzb28zYU9sditrVDhLeVlzMlR6a2hVemk1dFpMRVZiRWdGT2JWSTBxOE1X?=
 =?utf-8?B?S0QwUHlFQ1RSMHlaUVgydHJoSS82c1F0NTNQWUtjakFTT2xWUEI2NUxCWlVM?=
 =?utf-8?B?NVA2ak1jMEdOaG5jOThFaEJKQ3pWZ2xHNFh6L0RPV3MxY05qc0RicktaalRP?=
 =?utf-8?B?YWtpSEhQcHd1czY4YVhhZ1pieDByWEprQUpNeE5xQVJGMnl5WFVNakpBMDZp?=
 =?utf-8?B?N3V3MkcrdTdsMmxMZEJPQ2NjbmZWSkJkTlVCcXFmOE9JQnZkeDhhaXNJSmRG?=
 =?utf-8?B?YVFvOEZITnNmRjJCZENoem5Ea3ZXa2g2QlJCRnNkKzVvcHhCeWtkOU94czJh?=
 =?utf-8?B?YWRuV0FEemdNMHh6NzhQOFNLdXViamZ0R3ZJTEpud0pmZlBsZFpET1VVc1dP?=
 =?utf-8?B?Z1JPZ0tPbHgwTE1kSUtWRkFKSFdlM3RJbE9Ea2FFVlNXcFZ6VjVMdSt4MEow?=
 =?utf-8?B?L25OS2h0Ry9SRUNVT0MzK2NJa1BlQjJ4MWN0OUZnV1JGOGRQa2ttUWoxRUtl?=
 =?utf-8?B?cU9rSEU0WmExcmFZN0U2KzhaUjNoRldqMnpTNEZXQk1ZSjZvYy96bmk5OGJa?=
 =?utf-8?B?ZnhJTjZzcUo0MGZhd1A0S0ZaMnpHbjl5MHcvNUFjRHJtZWdPOXVVeWhkamxL?=
 =?utf-8?B?ck1kMXkrWDBjemtCL2NidkRqN2R5akxSSWl2bVkzc3FtMEVxSlliam13ZjZi?=
 =?utf-8?B?RlZCTkMvK1FDejR4Zm9xYU9NSXVCT1FRTElKemNpRTQ5TmZ6VnUyc25oZmVt?=
 =?utf-8?B?Rmh4dC84Tzd1NkdDeGlySDd4VTZsL2hZdWxVZy94MXVESHVrTng0bmdPUEgx?=
 =?utf-8?B?NnF1MkZPYXRIU0k3cStPdmE5TXBBLzcyM1dBVzBUUndjaWxjRkxQUWxSVFVE?=
 =?utf-8?B?V3Y2aEo0cVFiVGJyNExYNlZuOThhNHhRMFlKUXVoNWc0THRlUUE4ZFlaTzNZ?=
 =?utf-8?B?bzlzYWtBVGcyUGhmaStTMkl1ZWhQbEphbmI5dlBZRjhIakphTVRCeHN1TlFJ?=
 =?utf-8?B?UWdaQVE2M3o5WUVpRy82N2Mva0dsMVJ4OGZSSUJWckZTNUVaZ2k5aVRjUXZG?=
 =?utf-8?B?OHB4b0U0VWtRZ3IxZFRHRWxHZWt0Sno2dzduTFhOTkJ5a0xDT21obVVUZGJB?=
 =?utf-8?B?ZWF1MWdHdndNUHhKMEJjQ0FjbVVhd240aTFuT2s2MGtnamk3enExRjI4eVFn?=
 =?utf-8?B?SDMwZWZNSkdDTG1xckV3YlNMU2ZVMUxZcXR4MjhzWWJEdUYvR0Z2NUdQVEl3?=
 =?utf-8?B?VEFEZFdXcE1mNHpaMHJJMHlOZFVWeGxUQUx4UzVvT003d0kwREpzTEdRWEJZ?=
 =?utf-8?Q?btk17D4QcHHkLbMVhsxhcC0nwfmhsJW5lBplN5O?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49251d54-d3d2-4a27-a434-08d90efb95e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 12:53:16.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsqT0XYIZnb+YzC/3OQpysZmb5ayMGjpbIAdCjW69BNvpUnM3tE4wqPyxBNFVbC6phBYIFAy4GYaDtmFbTP4d9s+LY6Qxr/KkEf6mKnD9KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgQWxsLA0KDQo+IEkgZ3Vlc3MgdGhhdCBhYm92ZSBlcnJvciBmbGFncyBhcmUgdGhlIGNvbnNl
cXVlbmNlIG9mIHRoZQ0KPiBpbnRlcmZlcmVuY2VzIG9uIHRoZSBidXMgd2hpbGUgdW5wbHVnZ2lu
ZyB0aGUgY2FuZGxlbGlnaHQuIFRob3NlDQo+IGFyZSBwcm9iYWJseSBub3QgcmVsZXZhbnQgdG8g
b3VyIHNwZWNpZmljIHRvcGljLg0KPiANCj4gPiB8ICgyMDIxLTA1LTA0IDA5OjA1OjAyLjEwMDU0
MCkgIG1jcDI1MXhmZDAgIFJYIC0gLSAgMjIyICAgWzhdICA0RCAwMCAwMCAwMCAwMA0KPiAwMCAw
MCAwMA0KPiA+IHwgKDIwMjEtMDUtMDQgMDk6MDU6MDIuMTAwNTcwKSAgbWNwMjUxeGZkMCAgUlgg
LSAtICAyMjIgICBbOF0gIDREIDAwIDAwIDAwIDAwDQo+IDAwIDAwIDAwDQo+ID4gfCAoMjAyMS0w
NS0wNCAwOTowNTowMi4xMDA1ODMpICBtY3AyNTF4ZmQwICBSWCAtIC0gIDIyMiAgIFs4XSAgNEQg
MDAgMDAgMDAgMDANCj4gMDAgMDAgMDANCj4gPiB8ICgyMDIxLTA1LTA0IDA5OjA1OjAyLjEwMDU5
MykgIG1jcDI1MXhmZDAgIFJYIC0gLSAgMjIyICAgWzhdICA0RCAwMCAwMCAwMCAwMA0KPiAwMCAw
MCAwMA0KPiA+IHwgKDIwMjEtMDUtMDQgMDk6MDU6MDIuMTAxMzI2KSAgbWNwMjUxeGZkMCAgUlgg
LSAtICAyMjIgICBbOF0gIDREIDAwIDAwIDAwIDAwDQo+IDAwIDAwIDAwDQo+ID4NCkNvdWxkIGJl
LCB3b3VsZCBiZSB3b3J0aCB0byBjaGVjayB0aGF0IG9uZSBhIHNjb3BlLiBGcm9tIHdoYXQgSSd2
ZSBzZWVuIHNvIGZhciB0aGUgQnVzIGxvb2tzIGNsZWFuIHdpdGhvdXQgZGlzY29ubmVjdGluZyBu
b2Rlcy4NCg0KIA0KPiBTZWNvbmQsIHRoZSByZWNlaXZlciBiZWhhdmlvdXIgd2hlbiByZWNlaXZp
bmcgYW4gbm9uLUFDS2VkIGZyYW1lDQo+IGlzIGFjdHVhbGx5IHVuc3BlY2lmaWVkLiBBcyBtZW50
aW9uZWQgYmVmb3JlLCBub24tQUNLZWQgZnJhbWVzDQo+IHNob3VsZCBiZSBpbW1lZGlhdGVseSBm
b2xsb3dlZCBieSBhbiBBQ0sgZXJyb3IgZmxhZy4gSGVyZSwgdGhlDQo+IHJlY2VpdmluZyBub2Rl
cyBhcmUgZmFjaW5nIGEgc2l0dWF0aW9uIHdoaWNoIHNob3VsZCBuZXZlcg0KPiBvY2N1ci4gVGhl
IG1jcDI1MThmZCBkZWNpZGVzIHRvIHJlZ2lzdGVyIHRoZSBmcmFtZSBhcyByZWNlaXZlZA0KPiBh
bmQgdGhlIGZsZXhjYW4gZGVjaWRlcyB0byBub3QgcmVnaXN0ZXIgdGhlIGZyYW1lLiBJIHRoaW5r
IHRoYXQNCj4gYm90aCBiZWhhdmlvcnMgYXJlIGFjdHVhbGx5IGZpbmU6IHdpdGggdGhlIGxhY2sg
b2Ygc3BlY2lmaWNhdGlvbiwNCj4gdGhlIGltcGxlbWVudGF0aW9uIGlzIGZyZWUgdG8gZGVjaWRl
IGhvdyB0byBoYW5kbGUgdGhpcyBzaWRlDQo+IGNhc2UuDQoNCkknZCBzYXkgaXQgaXMgYWN0dWFs
bHkgZGVmaW5lZC4gSVNPIDExOTg5LTE6MjAxNSBzdGF0ZXMgdGhlIGZvbGxvd2luZyBpbiBjaGFw
dGVyIDEwLjQgQnVzIG1vbml0b3JpbmcNCiJPcHRpb25hbGx5LCBDQU4gaW1wbGVtZW50YXRpb25z
IG1heSBwcm92aWRlIHRoZSBidXMgbW9uaXRvcmluZyBtb2RlLCB3aGVyZSB0aGV5IHNoYWxsIGJl
IGFibGUgdG8gDQpyZWNlaXZlIHZhbGlkIERGcyBhbmQgdmFsaWQgUkZzLCBidXQgaXQgc2VuZHMg
b25seSByZWNlc3NpdmUgYml0cyBvbiB0aGUgQ0FOIG5ldHdvcmsgYW5kIGRvZXMgbm90IHN0YXJ0
IA0KYSB0cmFuc21pc3Npb24uIElmIHRoZSBNQUMgc3ViLWxheWVyIGlzIHJlcXVpcmVkIHRvIHNl
bmQgYSBkb21pbmFudCBiaXQgKEFDSyBiaXQsIG92ZXJsb2FkIGZsYWcsIGFjdGl2ZSANCmVycm9y
IGZsYWcpLCB0aGUgYml0IHNoYWxsIGJlIHJlcm91dGVkIGludGVybmFsbHkgc28gdGhhdCB0aGUg
TUFDIHN1Yi1sYXllciBtb25pdG9ycyB0aGlzIGRvbWluYW50IGJpdCwgDQphbHRob3VnaCB0aGUg
Q0FOIG5ldHdvcmsgbWF5IHJlbWFpbiBpbiByZWNlc3NpdmUgc3RhdGUuIg0KDQpMb29raW5nIGF0
IHRoZSBNQ0FOIG1hbnVhbCBoZXJlOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtY2FuL2Nhbi1k
b2MvYmxvYi9tYXN0ZXIvbV9jYW4vbWNhbl91c2Vyc19tYW51YWxfdjMzMC5wZGYNCg0KVGhlcmUn
cyBhIHNpbWlsYXIgZGVzY3JpcHRpb24gaW5jbHVkaW5nIGEgcGljdHVyZSBzaG93aW5nIHRoZSBU
WCBzaWduYWwgYmVpbmcgImNvbm5lY3RlZCIgaW50ZXJuYWxseSB0byB0aGUgUlggcGF0aCB0byBn
ZW5lcmF0ZSB0aGUgQWNrIGludGVybmFsbHkuDQoNClRob21hcw0K
